import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/theme/theme.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Color backgroundColor;
  // final Text title;
  // final AppBar appBar;
  // final List<Widget> widgets;

  const BaseAppBar(
      {Key? key,
      // required this.title,
      // required this.appBar,
      // required this.widgets,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      flexibleSpace: Container(
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 15, top: 80),
                child: Icon(Icons.macro_off)),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 80),
                  child: Text("Selamat siang, Sekar",
                      style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    "Semangat buat hari ini ya...",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                )
              ],
            ),
            const Spacer(),
            Padding(
                padding: EdgeInsets.only(top: 80, right: 15),
                child: GestureDetector(
                    onTap: () {
                      ;
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.blue300),
                    )))
          ],
        ),
      ),
      // title: title,
      // actions: widgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}