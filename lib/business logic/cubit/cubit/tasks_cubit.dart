import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<List<Task>> //task instead of string for more accuracy
{
  TasksCubit() : super([]);

  void addTask(String title) {
    final newTask = Task(title: title);
    emit([...state, newTask]); 
  }

  void toggleTask(int index) {
    final updatedList = List<Task>.from(state);
    final task = updatedList[index];
    
    updatedList[index] = task.copyWith(isDone: !task.isDone); 
    emit(updatedList);
  }

  void deleteTask(int index) {
    final updatedList = List<Task>.from(state);
    updatedList.removeAt(index);
    emit(updatedList);
  }
}
