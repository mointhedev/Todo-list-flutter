import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_app/models/task.dart';
import 'package:todoey_app/screens/add_task_screen.dart';

import '../TaskProvider.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => SingleChildScrollView(
                      child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskScreen(),
                  )));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Todoey',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  Provider.of<TaskProvider>(context).taskList.length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Consumer<TaskProvider>(builder: (context, taskData, child) {
              return taskData.taskList.length > 0
                  ? ListView.builder(
                      itemBuilder: ((context, index) {
                        Task task = taskData.taskList[index];
                        return Dismissible(
                          direction: DismissDirection.startToEnd,
                          // Each Dismissible must contain a Key. Keys allow Flutter to
                          // uniquely identify widgets.
                          key: UniqueKey(),
                          background: Container(
                            padding: EdgeInsets.only(left: 10),
                            color: Colors.red,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )),
                          ),
                          // Provide a function that tells the app
                          // what to do after an item has been swiped away.
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            taskData.deleteTask(task);

                            // Show a snackbar. This snackbar could also contain "Undo" actions.
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("Task Deleted")));
                          },
                          child: ListTile(
                            title: Text(taskData.taskList[index].task),
                            trailing: Checkbox(
                              value: taskData.taskList[index].isCompleted,
                              onChanged: (value) {
                                taskData.toggleTask(index);
                              },
                            ),
                          ),
                        );
                      }),
                      itemCount: taskData.taskList.length,
                    )
                  : Container(
                      padding: EdgeInsets.only(top: 50),
                      width: double.infinity,
                      child: Text(
                        'No Tasks Here',
                        textAlign: TextAlign.center,
                      ),
                    );
            }),
          ))
        ],
      ),
    );
  }
}
