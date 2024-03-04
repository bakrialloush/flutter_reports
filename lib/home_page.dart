import 'package:flutter/material.dart';
import 'package:flutter_reports/report_helper.dart';
import 'package:open_file/open_file.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reporting')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            generateReport('example.pdf').then((file) {
              OpenFile.open(file.path);
            }).catchError((e) {
              showErrorDialog(context, e);
            });
          },
          child: const Text('Generate report'),
        ),
      ),
    );
  }
}

Future<dynamic> showErrorDialog(BuildContext context, String msg) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(msg),
    ),
  );
}
