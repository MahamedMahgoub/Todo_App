import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:myapp/shared/bloc_observe.dart';
import 'package:myapp/todoapp/todo_layoutcubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: TodoLayoutcubit());
  }
}
