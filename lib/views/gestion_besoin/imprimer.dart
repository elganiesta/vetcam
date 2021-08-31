// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vetcam/models/besoin_model.dart';

class PreviewBesoins extends StatelessWidget {
  final List<BesoinModel> besoins;

  const PreviewBesoins({Key? key, required this.besoins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Imprimer Besoin"),
      ),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        pdfFileName:
            'FICHE BESOIN - ${DateFormat('yyyy_MM_d').format(DateTime.now())}',
        build: (format) => _generatePdf(format, besoins),
        onPrinted: (_) {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, List<BesoinModel> besoins) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final image = await imageFromAssetBundle('assets/images/vetcam.png');

    for (BesoinModel besoin in besoins)
      pdf.addPage(
        pw.Page(
          margin: pw.EdgeInsets.all(30.0),
          pageFormat: format,
          build: (context) {
            return pw.Column(
              children: [
                pw.Table(
                  border: pw.TableBorder.all(
                    width: 2,
                  ),
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            height: 70,
                            child: pw.Center(
                              child: pw.Image(image),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Center(
                            child: pw.Text(
                              "FICHE BESOIN",
                              style: pw.TextStyle(
                                  fontSize: 12, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Table(
                  border: pw.TableBorder.all(
                    width: 1,
                  ),
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pwCell('Date', true),
                        pwCell('Service', true),
                        pwCell('URGENT', true),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pwCell(besoin.date, false),
                        pwCell(besoin.service, false),
                        pwCell(besoin.urgent == true ? "X" : "", false),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Table(
                  border: pw.TableBorder.all(
                    width: 1,
                  ),
                  defaultVerticalAlignment:
                      pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pwCell('N°', true),
                        pwCell('Désignation', true),
                        pwCell('Quantité', true),
                        pwCell('Date de livraison souhaité', true),
                      ],
                    ),
                    for (var item in besoin.besoins)
                      pw.TableRow(
                        children: [
                          pwCell(item.numero, false),
                          pwCell(item.designation, false),
                          pwCell(item.quantite, false),
                          pwCell(item.observation, false),
                        ],
                      ),
                    for (var i = 0; i < (25 - besoin.besoins.length); i++)
                      pw.TableRow(
                        children: [
                          pwCell((besoin.besoins.length + i + 1).toString(),
                              false),
                          pwCell("", false),
                          pwCell("", false),
                          pwCell("", false),
                        ],
                      ),
                  ],
                ),
                pw.Spacer(),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    width: 200,
                    child: pw.Table(
                      border: pw.TableBorder.all(
                        width: 1,
                      ),
                      defaultVerticalAlignment:
                          pw.TableCellVerticalAlignment.middle,
                      children: [
                        pw.TableRow(
                          children: [
                            pwCell('Signature', true),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(height: 60),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

    return pdf.save();
  }
}

pwCell(String text, bool title) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: pw.BoxDecoration(color: title ? PdfColorGrey(0.8) : null),
    child: pw.Center(
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: title ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontSize: 8,
        ),
      ),
    ),
  );
}
