import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_simple_todo/blocs/todos/bloc/todos_bloc.dart';
import 'package:bloc_simple_todo/models/todos_edit.dart';
import 'package:bloc_simple_todo/models/todos_model.dart';
import 'package:equatable/equatable.dart';

part 'todos_edit_event.dart';
part 'todos_edit_state.dart';

class TodosEditBloc extends Bloc<TodosEditEvent, TodosEditState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosEditBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosEditInitial()) {
    on<UpdatedEdit>(_onUpdateEdit);
    on<UpdatedTodos>(_onUpdateTodos);

    _todosSubscription = todosBloc.stream.listen((state) {
      add(
        const UpdatedTodos(),
      );
    });
  }

  void _onUpdateEdit(UpdatedEdit event, Emitter<TodosEditState> emit) {
    if (state is TodosEditInitial) {
      add(
        const UpdatedTodos(todosEdit: TodosEdit.pending),
      );
    }
    if (state is TodosEditLoaded) {
      final state = this.state as TodosEditLoaded;
      add(
         UpdatedTodos(todosEdit: state.todosEdit),
      );
    }
  }

  void _onUpdateTodos(UpdatedTodos event, Emitter<TodosEditState> emit) {
    final state = _todosBloc.state;

    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.todosEdit) {
          case TodosEdit.all:
            return true;
          case TodosEdit.completed:
            return todo.isCompleted!;
          case TodosEdit.cancelled:
            return todo.isCancelled!;
          case TodosEdit.pending:
            return !(todo.isCancelled! || todo.isCompleted!);
        }
      }).toList();
      emit(TodosEditLoaded(listTodos: todos));
    }
  }
}
