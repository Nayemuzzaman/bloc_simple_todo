import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;

  bool? isCompleted;
  bool? isCancelled;

  Todo({
    required this.id,
    required this.task,
    required this.description,
     this.isCancelled,
     this.isCompleted,
  }) {
    isCancelled = isCancelled ?? false;
    isCompleted = isCompleted ?? false;
  }

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
        id: this.id,
        task: this.task,
        description: this.description,
        isCancelled: isCancelled,
        isCompleted: isCompleted);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        task,
        description,
        isCompleted,
        isCancelled,
      ];

  static List<Todo> todos = [
    Todo(id: '1', task: 'Sample to do 1', description: 'This is test to do'),

    Todo(id: '2', task: 'Sample to do 2', description: 'This is test to do'),

  ];
}
