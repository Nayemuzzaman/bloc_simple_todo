import 'package:bloc/bloc.dart';
import 'package:bloc_simple_todo/models/todos_model.dart';
import 'package:equatable/equatable.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodos>(_onAddTodos);
    on<DeleteTodos>(_onDeleteTodos);
    on<UpdateTodos>(_onUpdateTodos);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) {
    emit(
      TodosLoaded(todos: event.todos),
    );
  }

  void _onAddTodos(AddTodos event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      emit(TodosLoaded(
        todos: List.from(state.todos)..add(event.todo),
      ));
    }
  }

  void _onDeleteTodos(DeleteTodos event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();
      emit(
        TodosLoaded(todos: todos),
      );
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosState> emit) {
    final state = this.state;

    if (state is TodosLoaded) {
      List<Todo> todos = (state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList());

      emit(TodosLoaded(todos: todos));
    }
  }
}
