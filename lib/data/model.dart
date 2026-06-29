
import 'package:flutter/material.dart';

class Task {
  final String title;
  final bool isDone; //for the checkbox to be done and undone by switching the bool condition between true and false



  Task({required this.title, this.isDone = false}); //constructor required paramters


  Task copyWith({String? title, bool? isDone}) //copywith is used for switching one condition in the new object it makes (true to false in same task)
  {
    return Task(
      title: title ?? this.title, //if i added a value it will add it however if i font itll be null same with the code below thats why we use ??
      isDone: isDone ?? this.isDone,
    );
  }
}