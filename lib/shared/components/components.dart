import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: (){
          function() ;
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function ?onSubmit,
  Function ?onChange,
  Function ?onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData ?suffix ,
  Function ?suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (value){onSubmit!(value);},
      onChanged: (value){onChange!(value);},
      onTap: (){onTap!() ; },
      validator: (value){
        validate(value);

        },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: (){suffixPressed!();},
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );



Widget taskItem(Map myTask , context)=>Dismissible(
  child:   Padding(

    padding: const EdgeInsets.all(12),

    child: Row(



      children: [

        CircleAvatar(

          radius: 40,

          child: Text(

            '${myTask['time']}',

          ),

        ),

        SizedBox(

          width: 10,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Text(

                "${myTask['title']}",

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  color: Colors.black ,

                ),

              ),

              Text(

                "${myTask['date']}",

                style: TextStyle(



                  color: Colors.black45 ,

                ),

              ),

            ],

          ),

        ),

        SizedBox(

          width: 10,

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'done', id: myTask['id']);



            },

            icon: Icon(

                Icons.done,

              color: Colors.green,

            ),

        ),

        IconButton(

          onPressed: (){

            AppCubit.get(context).updateData(status: 'archived', id: myTask['id']);

          },

          icon: Icon(

            Icons.archive_rounded,

            color: Colors.black54,

          ),

        ),

      ],

    ),

  ),
  key: Key('${myTask['id'].toString()}'),
  onDismissed: (direction){
  AppCubit.get(context).deleteData(id: myTask['id']);
  },
);



