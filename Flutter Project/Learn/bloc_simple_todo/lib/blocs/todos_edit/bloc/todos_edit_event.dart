part of 'todos_edit_bloc.dart';

abstract class TodosEditEvent extends Equatable {
  const TodosEditEvent();

  @override
  List<Object> get props => [];
}

class UpdatedEdit extends TodosEditEvent {
  const UpdatedEdit();
 
  @override
  List<Object> get props => [];
}

class UpdatedTodos extends TodosEditEvent {
  final TodosEdit todosEdit;

  const UpdatedTodos({this.todosEdit = TodosEdit.all});

  @override
  List<Object> get props => [todosEdit];
}
