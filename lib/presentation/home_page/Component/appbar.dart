import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class appbar extends StatelessWidget {
  const appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 5, top: 80),
              child: CircleAvatar(
                backgroundColor: AppColor.background,
                radius: 20,
                //child: Image.asset("assets/logo_talentaku.png"),
              )),
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
                  left: 25,
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
          Spacer(),
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
    );
  }
}
