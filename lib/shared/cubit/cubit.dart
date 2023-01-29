import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialState());

  late Database database ;


  static AppCubit get(context)=> BlocProvider.of(context); // to get object






  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];



  int currentIndex = 0;


  List<Widget>screens = [
    NewTaksScreen(),
    DoneTaksScreen(),
    ArchievdTaksScreen(),
  ];

  List<String> appBarTitle = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index ){
    currentIndex = index ;
    emit(AppChangeBottomNavBarState());
  }



  void createDataBase ()  {
   openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database , version ) {

        print('database created');

        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)'
        ).then((value) {
          print('table created');
        }).catchError((error ){
          print (error.toString());
        });

      } ,
      onOpen: (database){
        getDataFromDataBase(database);
        print ('database opened');
      },
    ).then((value) {
      database = value ;
      emit(AppCreateDataBaseState());
    })   ;
  }


  insertToDatabase (
      {
        required String title ,
        required String date ,
        required String time ,
      }
      ) async {

     await database.transaction((txn){
      return txn.rawInsert(
          'INSERT INTO tasks(title , date , time , status)VALUES ("${title}" , "${date}" ,"${time}" ,"new")'
      ).then((value)
      {
        print ('AMR $value inserted successfully');
        emit(AppInsertDataBaseState());

        getDataFromDataBase(database);


        }).catchError((onError){
        print (onError.toString());
      });


    });

  }


  void getDataFromDataBase (database) {
    newTasks =[];
    doneTasks=[];
    archivedTasks =[];
    emit(AppGetDataBaseLoading());
     database.rawQuery('SELECT * from tasks').then((value){

       value.forEach((element){
         if (element['status'] == 'new') newTasks.add(element);
         else if (element['status'] == 'done') doneTasks.add(element);
         else archivedTasks.add(element);
       });


       emit(AppGetDataBaseState());

     });

  }

  void updateData(
  {
  required String status ,
  required int id,
  }) async {
     await database.rawUpdate(
        "UPDATE tasks SET status = ? WHERE id = ? " , [status , '$id' ]

    ).then((value){
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
     });
  }

  void deleteData(
      {

        required int id,
      }) async {
    await database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getDataFromDataBase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  bool isBottomSheetOpened = false ;
  Icon iconForFloatingActionBottom = Icon (Icons.edit) ;



  void changeBottomSheetState({
    required bool isShown ,
    required Icon icon ,

  }){

    isBottomSheetOpened = isShown ;
    iconForFloatingActionBottom = icon ;
    emit (AppChangeBottomSheetState()) ;

  }
  }








