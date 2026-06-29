import 'package:bloc_learning/business%20logic/cubit/cubit/tasks_cubit.dart';
import 'package:bloc_learning/presentation/screens/taskscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main(){
  runApp(
    BlocProvider(
    create: (_) => TasksCubit(),
    child: MyApp(),
  )
    );
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(debugShowCheckedModeBanner: false,
    home: TaskScreen(),);
  }

}