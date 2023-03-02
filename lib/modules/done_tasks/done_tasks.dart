import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/todoapp/todoapp_cubit/cubit.dart';
import 'package:myapp/todoapp/todoapp_cubit/states.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return TasksBulider(tasks: tasks);
      },
    );
  }
}
