import 'package:advanced_todo_app/models/todo_model.dart';
import 'package:advanced_todo_app/widgets/todo_edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final String des;
  final bool isDone;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Todo todo;
  const TodoTile({
    super.key,
    required this.title,
    required this.des,
    required this.isDone,
    required this.onTap,
    required this.onDelete, required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                        context: context,
                        builder: (context) => TodoEditDialog(todo: todo,),
                      );
            },
            icon: Icons.edit,
            backgroundColor: Colors.green.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: (context) {
              onDelete();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(
                    des,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Checkbox(
                value: isDone,
                onChanged: (value) {
                  onTap();
                },
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
