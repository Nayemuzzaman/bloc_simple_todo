part of 'todos_edit_bloc.dart';

abstract class TodosEditState extends Equatable {
  const TodosEditState();

  @override
  List<Object> get props => [];
}

class TodosEditInitial extends TodosEditState {}

class TodosEditLoaded extends TodosEditState {
  final List<Todo> listTodos;
  final TodosEdit todosEdit;

  const TodosEditLoaded({
    required this.listTodos,
    this.todosEdit = TodosEdit.all,
  });

   @override
  List<Object> get props => [
    listTodos,
    todosEdit,
  ];


}
