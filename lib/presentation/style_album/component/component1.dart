import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';

class component1 extends StatelessWidget {
  final String Foto;
  final String description;
  const component1({
    super.key,
    required this.Foto,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Judul Foto Kegiatan",
                  style: AppTextStyle.tsNormal,
                ),
                Text(
                  "May, 05 2024",
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Container(
                height: 32,
                width: 67,
                decoration: BoxDecoration(
                    color: AppColor.blue600,
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                    margin: EdgeInsets.all(6),
                    child: Text(
                      "Simpan",
                      style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold, color: AppColor.white),
                    )),
              ),
            )
          ]),
        ),
        Column(
          children: [
            Container(
              height: 319,
              width: 319,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(Foto),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(description),
            )
          ],
        )
      ],
    );
  }
}
