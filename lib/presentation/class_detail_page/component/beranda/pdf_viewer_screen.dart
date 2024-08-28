import 'package:flutter/material.dart';

// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../infrastructure/theme/theme.dart';

class PDFViewerScreen extends StatelessWidget {
  final String fileUrl;
  final String fileName;

  PDFViewerScreen({Key? key, required this.fileUrl, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fileName, 
          style: AppTextStyle.tsSmallRegular(AppColor.white), 
          overflow: TextOverflow.ellipsis),
        backgroundColor: AppColor.blue600
      ),
      // body: SfPdfViewer.network(
      //   fileUrl,
      //   canShowPaginationDialog: true,
      //   canShowScrollHead: true,
      //   canShowScrollStatus: true,
      //   enableTextSelection: true,
      // ),
      
    );
  }
}
//     return FutureBuilder<PdfController>(
//       future: _initPdfController(file),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text("Error opening PDF: ${snapshot.error}"));
//         } else if (snapshot.hasData) {
//           final pdfController = snapshot.data!;

//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.black,
//               leading: IconButton(
//                 icon: Icon(Icons.close, color: Colors.white),
//                 onPressed: () => Get.back(),
//               ),
//             ),
//             body: PdfView(
//               controller: pdfController,
//             ),
//           );
//         } else {
//           return Center(child: Text("Unknown error"));
//         }
//       },
//     );
//   }

//   Future<PdfController> _initPdfController(File file) async {
//     if (await file.exists()) {
//       return PdfController(
//         document: PdfDocument.openFile(file.path),
//       );
//     } else {
//       throw Exception("File does not exist at path: ${file.path}");
//     }
//   }
// }

