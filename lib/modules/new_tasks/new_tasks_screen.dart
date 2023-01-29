import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/components/components.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

import 'package:flutter/gestures.dart';

import '../../shared/components/constants.dart';

class NewTaksScreen extends StatelessWidget {
  const NewTaksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(

      listener: (context , state){},
      builder: (context,state){
        return ConditionalBuilder(
            condition: AppCubit.get(context).newTasks.length > 0,
            builder: (context)=>ListView.separated(
              itemBuilder: (context ,index  ) => taskItem(AppCubit.get(context).newTasks[index] , context),
              separatorBuilder: (context , index ) =>Container(
                width: double.infinity,
                height: 1.5,
                color: Colors.grey[300],
              ),
              itemCount: AppCubit.get(context).newTasks.length ,
            ) ,
            fallback: (context)=>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Icon(
                    Icons.menu,
                    color: Colors.black45,
                    size: 50,
                  ),
                  Text(
                    'Great Work , Keep Going With New Tasks ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      color: Colors.black45,
                    ),
                  ),
                  GestureDetector(
                    onLongPress: (){
                      print ("Hello AMR AMR") ;
                    },
                    child: Text('data'),
                  )
                ],
              ),
            ),
        );
      },

    );
  }
}