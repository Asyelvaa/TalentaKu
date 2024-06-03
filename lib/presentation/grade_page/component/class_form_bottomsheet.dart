import 'package:flutter/material.dart';

class AddClassBottomSheet extends StatelessWidget {
  final Function(String) onAddClass;
  final TextEditingController _classController = TextEditingController();

  AddClassBottomSheet({required this.onAddClass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _classController,
            decoration: InputDecoration(labelText: 'Nama Kelas'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_classController.text.isNotEmpty) {
                onAddClass(_classController.text);
                Navigator.pop(context);
              }
            },
            child: Text('Tambah Kelas'),
          ),
        ],
      ),
    );
  }
}