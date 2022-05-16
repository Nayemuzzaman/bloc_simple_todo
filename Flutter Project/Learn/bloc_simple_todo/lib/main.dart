import 'package:bloc_simple_todo/blocs/todos/bloc/todos_bloc.dart';
import 'package:bloc_simple_todo/blocs/todos_edit/bloc/todos_edit_bloc.dart';
import 'package:bloc_simple_todo/models/todos_model.dart';
import 'package:bloc_simple_todo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  {
    runApp(const MyApp());
  }
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodos(todos: [
                Todo(
                    id: '1',
                    task: 'Office Meeting',
                    description: 'With general member & motivation'),
                Todo(
                    id: '2',
                    task: 'Coffee Meeting',
                    description: 'Meeting with Siraj'),
              ]),
            ),
        ),
        BlocProvider(
          create: (context) =>
              TodosEditBloc(todosBloc: BlocProvider.of<TodosBloc>(context))..add(UpdatedEdit()),
        ),
      ],
      child: MaterialApp(
        title: 'BloC- To DO',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color(0xFF000A1F),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF000A1F),
            )),
        home: const HomeScreen(),
      ),
    );
  }
}
