import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/materi_tugas/materi_item.dart';

class ContentMateriTugas extends StatelessWidget {
  const ContentMateriTugas({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          MateriItem(
            title: 'Matematika Lanjut', 
            tenggat: 'Tenggat: May, 05 2024'
          ),
          MateriItem(
            title: 'Matematika Lanjut', 
            tenggat: 'Tenggat: May, 05 2024'
          )
        ],
      ),
    );
  }
}