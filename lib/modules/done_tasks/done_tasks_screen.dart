import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTaksScreen extends StatelessWidget {
  const DoneTaksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(

      listener: (context , state){},
      builder: (context,state){
        return ConditionalBuilder(
            condition: AppCubit.get(context).doneTasks.length>0,
            builder: (context)=>ListView.separated(
              itemBuilder: (context ,index  ) => taskItem(AppCubit.get(context).doneTasks[index] , context),
              separatorBuilder: (context , index ) =>Container(
                width: double.infinity,
                height: 1.5,
                color: Colors.grey[300],
              ),
              itemCount: AppCubit.get(context).doneTasks.length ,
            ),
            fallback: (context)=>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.menu,
                    color: Colors.black45,
                    size: 50,
                  ),
                  Text(
                    'You Have Not Finished Any Thing',
                    style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
        );
      },

    );
  }
}