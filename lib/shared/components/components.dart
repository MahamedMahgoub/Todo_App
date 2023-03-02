import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:myapp/todoapp/todoapp_cubit/cubit.dart';

Widget defulteButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double reduis = 0.0,
  required Function() onPressed,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(reduis),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget bulidTaskItem(Map modul, context) => Dismissible(
      key: Key(modul['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              child: Text('${modul['date']}'),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${modul['title']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${modul['time']}',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData('done', modul['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData('archive', modul['id'.toString()]);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).deleteData(modul['id']);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.brown,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(modul['id']);
      },
    );

Widget TasksBulider({required List<Map> tasks}) => Center(
      child: ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (context) => ListView.separated(
          itemBuilder: (context, index) => bulidTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          itemCount: tasks.length,
        ),
        fallback: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu, size: 80.0, color: Colors.grey[300]),
            Text(
              'Please Add Some Items',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
