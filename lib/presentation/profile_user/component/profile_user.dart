import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? photo;
  const ProfilePicture({this.photo});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: photo != null
          ? NetworkImage(photo!)
          : AssetImage('assets/images/anak.png') as ImageProvider,
    );
  }
}
