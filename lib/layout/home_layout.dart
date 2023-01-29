import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';



import '../modules/archived_tasks/archived_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';



class HomeLayout extends StatelessWidget {


  var titleController = TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();




  HomeLayout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create:(BuildContext context)=>AppCubit()..createDataBase(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context , AppStates state){
              if (state is AppInsertDataBaseState){
                Navigator.pop(context);
              }
            },
            builder: (BuildContext context , AppStates state){


              return Scaffold(
                key: scaffoldKey ,
                appBar: AppBar(
                  title: Text(
                    AppCubit.get(context).appBarTitle[AppCubit.get(context).currentIndex],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: state is! AppGetDataBaseLoading ,
                  builder: (context)=>AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
                  fallback: (context)=>const Center(child: CircularProgressIndicator()),
                ),

                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if(AppCubit.get(context).isBottomSheetOpened){


                      /*
                  use Navigator.pop to remove the last action which is opening bottom sheet using floating action button
                 */

                      if (titleController.text.isNotEmpty && dateController.text.isNotEmpty && timeController.text.isNotEmpty) { //// for validation


                        AppCubit.get(context).insertToDatabase(
                          title: titleController.text ,
                          date: dateController.text,
                          time: timeController.text,
                        );
                        // insertToDatabase(
                        //   title: titleController.text,
                        //   date: dateController.text,
                        //   time: timeController.text,
                        // ).then((value) {
                        //
                        //   Navigator.pop(context);
                        //   isBottomSheetOpened = false;
                          /* setState(() {
                      iconForFloatingActionBottom = Icon(Icons.edit);
                    });*/

                        //});



                      }
                    }
                    else{

                      /*setState(() {
                  iconForFloatingActionBottom = Icon(Icons.add);
                  isBottomSheetOpened = true ;
                });*/
                      /*
                  bottom sheet to add new tasks

                 */
                      scaffoldKey.currentState?.showBottomSheet(
                            (context) =>Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(15.0 , ),
                          child: Form(
                            key : formKey ,
                            child: Column(

                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validate: ( value){
                                    if (value == null || value.isEmpty){
                                      return 'Title Must Not Be Empty .' ;
                                    }
                                    return null ;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),

                                const SizedBox(
                                  height: 15.0,
                                ),

                                defaultFormField(
                                  onTap: (){
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text = value!.format(context).toString() ;
                                    });
                                  },
                                  controller: timeController,
                                  type: TextInputType.datetime,

                                  validate: (value){
                                    if (value == null || value.isEmpty){
                                      return 'Time Must Not Be Empty .' ;
                                    }
                                    return null ;
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.alarm,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(

                                  onTap: (){
                                    showDatePicker(context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2025-05-03'),
                                    ).then((value){
                                      dateController.text = DateFormat.yMMMMd().format(value!) ;
                                      print(dateController);
                                    });

                                  },
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  validate: (String value){
                                    if (value == null || value.isEmpty){
                                      return 'Date Must Not Be Empty .' ;
                                    }
                                    return null ;
                                  },
                                  label: 'Task Date',
                                  prefix: Icons.calendar_today,
                                ),
                              ],

                            ),
                          ),
                        ),
                      ).closed.then((value) {

                        // Navigator.pop(context);
                        // AppCubit.get(context).isBottomSheetOpened = false;

                        AppCubit.get(context).changeBottomSheetState(
                          isShown:false ,
                          icon: Icon(Icons.edit),
                        );



                      });


                      AppCubit.get(context).changeBottomSheetState(isShown: true, icon: Icon(Icons.add));
                    }



                    //insertToDatabase() ;
                  },
                  child: AppCubit.get(context).iconForFloatingActionBottom ,


                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: AppCubit.get(context).currentIndex,
                  onTap: (index) {
                    AppCubit.get(context).changeIndex(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  items:
                  const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.menu,
                        ),
                        label: 'Tasks'
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.done_all_rounded,
                      ),
                      label: 'Done',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.archive_rounded,
                      ),
                      label: 'Archived',
                    ),

                  ],
                ),

              );
          },
        ),
    );


  }

  Future<String> myFun() async {
    return 'amr';
  }




}
