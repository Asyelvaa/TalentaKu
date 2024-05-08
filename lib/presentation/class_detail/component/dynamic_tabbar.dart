import 'package:flutter/material.dart';

class DynamicTabBar extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabContents;

  DynamicTabBar({
    required this.tabTitles,
    required this.tabContents,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        children: [
          TabBar(
            tabs: tabTitles.map((title) => Tab(text: title)).toList(),
            labelColor: Colors.black, // Ubah warna label yang dipilih sesuai kebutuhan
          ),
          Expanded(
            child: TabBarView(
              children: tabContents,
            ),
          ),
        ],
      ),
    );
  }
}
