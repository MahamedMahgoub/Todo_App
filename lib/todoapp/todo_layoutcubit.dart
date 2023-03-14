import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/shared/components/text_formfiled.dart';
import 'package:myapp/todoapp/todoapp_cubit/cubit.dart';
import 'package:myapp/todoapp/todoapp_cubit/states.dart';

class TodoLayoutcubit extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /*..creatDatabase() لاما حطتين نقطتين بعد الميثود اكنى حولتها لمتغير وبستدعى اللى جواها  */
      create: (BuildContext context) => AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppLoadingDatabaseState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBootomSheetShown) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertDatabase(titleController.text,
                        dateController.text, timeController.text);
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet((context) => Container(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DefulatTextFelid(
                                        controller: titleController,
                                        labelText: 'Tittle',
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Tittle must not be empty';
                                          }
                                          return null;
                                        },
                                        pefix: Icon(
                                          Icons.title_outlined,
                                        )),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    DefulatTextFelid(
                                      controller: timeController,
                                      labelText: 'Time',
                                      keyboardType: TextInputType.datetime,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          /*timeController.text
                                      خنا انا استخدمت السطر دا علشان اقوله يحطلى القيمه اللى هختارها ف التسكت فيلد بتاعى */
                                          timeController.text =
                                              value!.format(context).toString();
                                          print(value.format(context));
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Time must not be empty';
                                        }
                                        return null;
                                      },
                                      pefix: Icon(Icons.watch_later_outlined),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    DefulatTextFelid(
                                      controller: dateController,
                                      labelText: 'Date',
                                      keyboardType: TextInputType.datetime,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse('2023-02-10'),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMEd()
                                                  .format(value!);
                                          print(DateFormat.yMMMEd()
                                              .format(value));
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Date must not be empty';
                                        }
                                        return null;
                                      },
                                      pefix:
                                          Icon(Icons.calendar_today_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.ChangeBootomSheetState(false, Icons.edit);
                  });

                  cubit.ChangeBootomSheetState(true, Icons.add);
                }
              },
              child: Icon(
                cubit.fabicon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived',
                  ),
                ]),
          );
        },
      ),
    );
  }

  Future<String> getname() async {
    return 'Mohamed Samy';
  }
}
