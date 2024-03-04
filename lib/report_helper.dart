import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<File> generateReport(String fileName) async {
  final font = await PdfGoogleFonts.notoNaskhArabicMedium();
  final pdf = Document();
  pdf.addPage(Page(
    pageFormat: PdfPageFormat.a4,
    build: (_) => report1(font),
  ));

  final output = await getDownloadsDirectory();

  final file = File('${output!.path}/$fileName');
  final pdfData = await pdf.save();
  await file.writeAsBytes(pdfData);
  return file;
}

Widget report1(Font font) {
  return Center(
    child: Text(
      'تجريب الطباعة',
      textDirection: TextDirection.rtl,
      style: TextStyle(font: font, fontSize: 30),
    ),
  );
}
