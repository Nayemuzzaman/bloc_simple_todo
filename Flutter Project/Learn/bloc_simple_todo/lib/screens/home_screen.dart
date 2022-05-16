
import 'package:bloc_simple_todo/blocs/todos/bloc/todos_bloc.dart';
import 'package:bloc_simple_todo/blocs/todos_edit/bloc/todos_edit_bloc.dart';
import 'package:bloc_simple_todo/models/todos_edit.dart';
import 'package:bloc_simple_todo/models/todos_model.dart';
import 'package:bloc_simple_todo/screens/add_to_do_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   GlobalKey key =  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BloC To Do'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosEditBloc>(context)
                      .add(const UpdatedTodos(
                    todosEdit: TodosEdit.pending,
                  ));
                  break;
                case 1:
                  BlocProvider.of<TodosEditBloc>(context)
                      .add(const UpdatedTodos(
                    todosEdit: TodosEdit.completed,
                  ));
                  break;
              }
            },
            tabs: const [
              Tab(
                icon: Icon(Icons.pending),
              ),
              Tab(
                icon: Icon(Icons.add_task),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          _todos('Pending Task'),
          _todos('Completed Task'),
        ]),
      ),
    );
  }

  BlocConsumer<TodosEditBloc, TodosEditState> _todos(String title) {
    return BlocConsumer<TodosEditBloc, TodosEditState>(
      listener: (context, state) {
        if (state is TodosEditLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                '${state.listTodos.length} To do in your ${state.todosEdit.toString().split('.').last}'),
          ));
        }
      },
      builder: (context, state) {
        if (state is TodosEditInitial) {
          return const CircularProgressIndicator();
        }
        if (state is TodosEditLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  
                  shrinkWrap: true,
                  itemCount: state.listTodos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _todoCard(context, state.listTodos[index]);
                  },
                  key: key,
                ),
                
              ],
            ),
          );
        } else {
          return const Text('Something went worng');
        }
      },
    );
  }
      

  Card _todoCard(BuildContext context, Todo todo) {

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
            
            GestureDetector( 
              child: Text(
                '#${todo.id}: ${todo.task}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                
              ),
              
              onTap: () {
                showMoreText('${todo.description}');
                
              },
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(UpdateTodos(
                          todo: todo.copyWith(isCompleted: true),
                        ));
                  },
                  icon: const Icon(Icons.add_task),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          DeleteTodos(todo: todo),
                        );
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showMoreText(String text) {

    ShowMoreTextPopup popup = ShowMoreTextPopup(  context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: 200,
        width: 200,
        backgroundColor: Color(0xFF16CCCC),
        padding: EdgeInsets.all(4.0),
        borderRadius: BorderRadius.circular(10.0), onDismiss: () {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Dismiss callback!")));
    });

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }
}
