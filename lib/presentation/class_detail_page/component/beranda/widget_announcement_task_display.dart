import 'package:flutter/material.dart';

class CustomWidgetAnnouncementTaskDisplay extends StatelessWidget {
  final Map<String, dynamic> task;
  CustomWidgetAnnouncementTaskDisplay ({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Task: ${task['preview']}'),
      subtitle: Text('Created at: ${task['created_at']}'),
    );
  }
}