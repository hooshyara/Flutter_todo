import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'task.dart';
class TaskProvier extends ChangeNotifier{
  final List<Task> taskList = [
    Task(title: 'title 1', text: "text 1", is_done: true),
    Task(title: 'title 2', text: "text 2", is_done: false),
  ];

  List<Task> get tasks => taskList;

  void create({required Task task}){
    taskList.add(task);
    notifyListeners();
  }

  void delete({required String id}){
    taskList.removeWhere((element) => element.id == id);
    notifyListeners();

  }
}