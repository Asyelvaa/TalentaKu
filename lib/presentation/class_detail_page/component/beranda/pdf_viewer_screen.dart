import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart';

class PDFViewerScreen extends StatelessWidget {
  final File file;

  PDFViewerScreen({required this.file});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PdfController>(
      future: _initPdfController(file),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error opening PDF: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final pdfController = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
            body: PdfView(
              controller: pdfController,
            ),
          );
        } else {
          return Center(child: Text("Unknown error"));
        }
      },
    );
  }

  Future<PdfController> _initPdfController(File file) async {
    if (await file.exists()) {
      return PdfController(
        document: PdfDocument.openFile(file.path),
      );
    } else {
      throw Exception("File does not exist at path: ${file.path}");
    }
  }
}
