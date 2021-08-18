import 'dart:io';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart' as path;


class TestExcel extends StatefulWidget {
  const TestExcel({Key? key}) : super(key: key);

  @override
  State<TestExcel> createState() => _TestExcelState();
}

class _TestExcelState extends State<TestExcel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              ByteData data = await rootBundle.load("assets/files/ordres.xlsx");
              var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
              var excel = Excel.decodeBytes(bytes);

              // for (var table in excel.tables.keys) {
              //   print(table); //sheet Name
              //   print(excel.tables[table]?.maxCols);
              //   print(excel.tables[table]?.maxRows);
              //   for (var row in excel.tables[table]!.rows) {
              //     print("$row");
              //   }
              // }

              Sheet sheetObject = excel['ORDRES'];
              print(sheetObject.appendRow(['5','5','5','5','5','5','5']));

              print("######");
              print(sheetObject.rows);

              var fileName = 'something.xlsx';
              var savingPath = path.absolute('assets\\exports', fileName);
              print(savingPath);
              List<int> fileBytes = excel.save(fileName: fileName)!.toList();
              File(savingPath)
                ..createSync(recursive: true)
                ..writeAsBytesSync(fileBytes);
            },
            child: const Text('Load'),
          )
        ],
      ),
    );
  }
}
