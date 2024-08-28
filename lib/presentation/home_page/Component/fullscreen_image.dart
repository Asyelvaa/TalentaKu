import 'package:flutter/material.dart';

class FShomePage extends StatelessWidget {
  final String photoList;

  const FShomePage({Key? key, required this.photoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Image.network(
            photoList,
            fit: BoxFit.contain,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Text('Error loading image');
            },
          ),
        ),
      ),
    );
  }
}
