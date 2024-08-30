import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PDFViewerScreen extends StatefulWidget {
  final String fileUrl;
  final String fileName;

  PDFViewerScreen({required this.fileUrl, required this.fileName});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  bool _isLoading = true;
  PDFDocument? _pdfDocument;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final document = await PDFDocument.fromURL(widget.fileUrl);
      setState(() {
        _pdfDocument = document;
        _isLoading = false;
      });
    } catch (e) {
      // Handle the error (e.g., display an error message or log the error)
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pdfDocument != null
              ? PDFViewer(document: _pdfDocument!)
              : Center(child: Text('Failed to load PDF')),
    );
  }
}
