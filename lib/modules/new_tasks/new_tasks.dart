import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/todoapp/todoapp_cubit/cubit.dart';
import 'package:myapp/todoapp/todoapp_cubit/states.dart';

class NewTasks extends StatelessWidget {
  @override
  /* دى الليست اللى معموله بالبلوك */
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return TasksBulider(tasks: tasks);
      },
    );
  }
}


/* دى الليست اللى بدون بلوك 
 Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => bulidTaskItem(tasks[index]),
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
      itemCount: tasks.length,
    );
  }
 */