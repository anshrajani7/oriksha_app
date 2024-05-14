import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../core/Utils/color_constant.dart';
import 'custom_appBar.dart'; // Import Get for navigation

class PdfViewScreen extends StatefulWidget {
  final String title;
  final String finaleParth;
  final String fileName;
   PdfViewScreen({Key? key, required this.title, required this.finaleParth, required this.fileName}) : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  RxString pathPDF = "".obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.waitUntilFirstFrameRasterized.then((value) =>loadPdfAsset(widget.finaleParth, widget.fileName));
  }

  Future<void> loadPdfAsset(String asset, String filename) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      if (!await file.exists()) {
        var data = await rootBundle.load(asset);
        var bytes = data.buffer.asUint8List();
        await file.writeAsBytes(bytes, flush: true);
      }

        pathPDF.value = file.path;

    } catch (e) {
      print('Error loading PDF: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          onPressed: () {
            Navigator.pop(context);
          },
          text: widget.title,
        ),
      ),
      body: Obx(
          ()=> Center(
          child:  pathPDF.isNotEmpty
              ? PDFViewer(file: File(pathPDF.value))
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class PDFViewer extends StatefulWidget {
  final File file;

  const PDFViewer({Key? key, required this.file}) : super(key: key);

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late PDFViewController _pdfController;

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: widget.file.path,
      onViewCreated: (PDFViewController pdfViewController) {
        _pdfController = pdfViewController;
      },
    );
  }
}
