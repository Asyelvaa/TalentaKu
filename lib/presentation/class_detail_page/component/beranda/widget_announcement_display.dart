import 'package:flutter/material.dart';

class CustomWidgetAnnouncementDisplay extends StatelessWidget {
  final Map<String, dynamic> announcement;
  CustomWidgetAnnouncementDisplay({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: announcement['user'] != null
      //     ? CircleAvatar(
      //         backgroundImage: NetworkImage(
      //             'https://yourapiurl.com${announcement['user']['photo']}'),
      //       )
      //     : null,
      title: Text('announcement: ${announcement['preview']}'),
      subtitle: Text('By: ${announcement['user']['name']}'),
    );
  }
}