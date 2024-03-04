import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reporting')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final pdf = pw.Document();
            PdfGoogleFonts.cairoMedium().then((font) {
              pdf.addPage(pw.Page(
                  pageFormat: PdfPageFormat.letter,
                  build: (_) {
                    return pw.Center(
                      child: pw.Text(
                        'تجريب الطباعة',
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            font: font, fontSize: 30, color: PdfColors.red),
                      ),
                    );
                  }));
              getDownloadsDirectory().then((output) {
                final file = File('${output!.path}/example.pdf');
                pdf
                    .save()
                    .then((value) => file
                            .writeAsBytes(value, mode: FileMode.write)
                            .then((_) {
                          log(file.path);
                          OpenFile.open(file.path);
                        }).catchError((_) {
                          showErrorDialog(context, 'Error on write pdf data');
                        }))
                    .catchError((_) {
                  showErrorDialog(context, 'Error on save pdf');
                });
              }).catchError((_) {
                showErrorDialog(context, 'Error on select downloads path');
              });
            }).catchError((_) {
              showErrorDialog(context, 'Error on loading font');
            });
          },
          child: const Text('Generate report'),
        ),
      ),
    );
  }

  Future<dynamic> showErrorDialog(BuildContext context, String msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(msg),
      ),
    );
  }
}
