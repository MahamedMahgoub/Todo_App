import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/modules/archived_tasks/archived_tasks.dart';
import 'package:myapp/modules/done_tasks/done_tasks.dart';
import 'package:myapp/modules/new_tasks/new_tasks.dart';
import 'package:myapp/todoapp/todoapp_cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void creatDatabase() {
    openDatabase(
      'todoappp.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');

        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, stuts TEXT)')
            .then((value) {})
            .catchError((error) {
          print('Error is ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('Database Opened');
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase(
    @required String ti,
    @required String t,
    @required String d,
  ) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, stuts) VALUES("$ti", "$d", "$t", "new")')
          .then((value) {
        print('$value INSERT SUCCESFILLY');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when insert record ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppLoadingDatabaseState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['stuts'] == 'new') {
          newTasks.add(element);
        } else if (element['stuts'] == 'done') {
          doneTasks.add(element);
        } else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData(
    @required String stuts,
    @required int id,
  ) async {
    return await database.rawUpdate('UPDATE tasks SET stuts = ? WHERE id = ?',
        ['$stuts', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData(
    @required int id,
  ) async {
    return await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeletDatabaseState());
    });
  }

  bool isBootomSheetShown = false;
  IconData fabicon = Icons.edit;

  void ChangeBootomSheetState(
    bool isShow,
    IconData icon,
  ) {
    isBootomSheetShown = isShow;
    fabicon = icon;

    emit(AppChangeBottomSheetState());
  }
}
