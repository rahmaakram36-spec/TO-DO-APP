import 'package:bloc_learning/business logic/cubit/cubit/tasks_cubit.dart';
import 'package:bloc_learning/data/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final TextEditingController controller = TextEditingController(); //for input to work when taken from user through textfield

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: const Text(
          "Tasks",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,  //to not make the task centered 
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(  //the + sign youll find at the very bottom right in the ui
        onPressed: () {
          context.read<TasksCubit>().addTask(controller.text);
          controller.clear();  //the logic here is that once u enter the task through the text field it
          // will add it using the method we made in cubit which is add task and update the title found later in the container with the entered task by the use of emit 
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Cards(),
            const SizedBox(height: 20),
            TextField(
              controller: controller, //connect the widget to the controller i made at the beginning
              decoration: InputDecoration(
                hintText: "Add a task...",  //a task to help the user understand  more whats needed (hint)
                prefixIcon: const Icon(Icons.edit),
                filled: true, //makes the textfield have a backgrounf color
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(child: TaskContainer()),
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, List<Task>>(
      builder: (context, tasks) {
        final completed = tasks.where((t) => t.isDone).length;
        final pending = tasks.where((t) => !t.isDone).length;

        return Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pending_actions_rounded,
                        color: Colors.grey.shade700),
                    const SizedBox(height: 12),
                    Text(
                      "$pending",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Pending",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.done_outline_rounded,
                        color: Colors.grey.shade700),
                    const SizedBox(height: 12),
                    Text(
                      "$completed",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Completed",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TaskContainer extends StatelessWidget {
  const TaskContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, List<Task>>(
      builder: (context, tasks) {
        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.task_alt, size: 70, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "No tasks yet",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: task.isDone
                    ? Colors.grey.shade100
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: task.isDone,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onChanged: (_) {
                      context.read<TasksCubit>().toggleTask(index);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: task.isDone
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isDone
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        size: 18, color: Colors.grey.shade600),
                    onPressed: () {
                      context.read<TasksCubit>().deleteTask(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}