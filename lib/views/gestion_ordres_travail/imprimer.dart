// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

class PreviewOrdreTravail extends StatelessWidget {
  final OrdreTravailModel ordre;

  const PreviewOrdreTravail({Key? key, required this.ordre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: GFColors.DARK,
          title: const Text("Imprimer Ordre"),
        ),
        body: PdfPreview(
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          build: (format) => _generatePdf(format, ordre),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, OrdreTravailModel ordre) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final image = await imageFromAssetBundle('assets/images/vetcam.png');

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(40.0),
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Table(
                  border: pw.TableBorder.all(
                    width: 2,
                  ),
                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Container(
                          child: pw.Image(image),
                          width: 100
                        ),
                        pw.Center(
                          child: pw.Text(
                            "ORDRE DU TRAVAIL",
                            style: pw.TextStyle(
                                fontSize: 24, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 20,
                ),
                // Date, time, demandeur, n ordre
                pw.Table(
                  border: pw.TableBorder.all(
                    // color: Colors.black,
                    width: 1,
                  ),
                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pwCell('DEBUT', true),
                        pwCell('FIN', true),
                        pwCell('DUREE', true),
                        pwCell('DEMANDEUR', true),
                        pwCell('N° ORDRE', true),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pwCell(ordre.dateTimeDebut, false),
                        pwCell(ordre.dateTimeFin, false),
                        pwCell('', false),
                        pwCell(ordre.demandeur, false),
                        pwCell(ordre.id, false),
                      ],
                    ),
                  ],
                ),
                // Unite
                pw.Table(
                  border: pw.TableBorder.all(
                    // color: Colors.black,
                  ),
                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pwCell('UNITE BENIFICIARE', true),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pwCell(ordre.unite, false),
                      ],
                    ),
                  ],
                ),
                // Type du travail
                pw.Table(
                  border: pw.TableBorder.all(
                    // color: Colors.black,
                  ),
                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pwCell('TYPE DU TRAVAIL', true),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pwCell('Test', false),
                      ],
                    ),
                  ],
                ),
                // Travail demande
                pw.Table(
                  border: pw.TableBorder.all(
                    // color: Colors.black,
                  ),
                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.TableRow(
                      children: [
                        pwCell('TRAVAIL DEMANDE', true),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Text('Test'),
                      ],
                    ),
                  ],
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
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Center(
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontWeight: title ? pw.FontWeight.bold : pw.FontWeight.normal,
            fontSize: title ? 12 : 8,
          ),
        ),
      ),
    );
  }