// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/models/ordre_travail_model.dart';

class PreviewOrdreTravail extends StatelessWidget {
  final OrdreTravailModel ordre;

  const PreviewOrdreTravail({Key? key, required this.ordre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: GFColors.DARK,
        title: const Text("Imprimer Ordre"),
      ),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        pdfFileName:
            'Ordre travail N ${ordre.id} - ${DateFormat('yyyy_MM_d').format(DateTime.now())}',
        build: (format) => _generatePdf(format, ordre),
        onPrinted: (_) {
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, OrdreTravailModel ordre) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final image = await imageFromAssetBundle('assets/images/vetcam.png');

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
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
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
                            "ORDRE DU TRAVAIL",
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
              // Date, time, demandeur, n ordre
              pw.Table(
                border: pw.TableBorder.all(
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
                  width: 1,
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
                      pw.Table(
                        border: pw.TableBorder.all(
                          width: 0.5,
                        ),
                        children: [
                          pw.TableRow(
                            children: unites
                                .map((unite) {
                                  return pwCell(unite, false);
                                })
                                .toList()
                                .cast<pw.Widget>(),
                          ),
                          pw.TableRow(
                            children: unites
                                .map((unite) {
                                  if (unite == ordre.unite)
                                    return pwCell("X", false);
                                  else
                                    return pwCell("", false);
                                })
                                .toList()
                                .cast<pw.Widget>(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Type du travail
              pw.Table(
                border: pw.TableBorder.all(
                  width: 1,
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
                      pw.Table(
                        border: pw.TableBorder.all(
                          width: 0.5,
                        ),
                        children: [
                          pw.TableRow(
                            children: typesTravail
                                .map((type) {
                                  return pwCell(type, false);
                                })
                                .toList()
                                .cast<pw.Widget>(),
                          ),
                          pw.TableRow(
                            children: typesTravail
                                .map((type) {
                                  var result = ordre.types.firstWhere(
                                      (e) => e == type,
                                      orElse: () => null);
                                  if (result != null)
                                    return pwCell("X", false);
                                  else
                                    return pwCell("", false);
                                })
                                .toList()
                                .cast<pw.Widget>(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Travail demande
              pw.Table(
                border: pw.TableBorder.all(
                  width: 1,
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
                      pwCell(ordre.travail, false),
                    ],
                  ),
                ],
              ),
              //Pieces jointes
              pw.Table(
                border: pw.TableBorder.all(
                  width: 1,
                ),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      pwCell('PIECES ', true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Table(
                        border: pw.TableBorder.all(
                          width: 0.5,
                        ),
                        children: [
                          pw.TableRow(
                            children: pieces
                                .map((piece) {
                                  return pwCell(piece, false);
                                })
                                .toList()
                                .cast<pw.Widget>(),
                          ),
                          pw.TableRow(
                            children: pieces
                                .map((piece) {
                                  var result = ordre.pieces.firstWhere(
                                      (e) => e == piece,
                                      orElse: () => null);
                                  if (result != null)
                                    return pwCell("X", false);
                                  else
                                    return pwCell("", false);
                                })
                                .toList()
                                .cast<pw.Widget>(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(
                  width: 1,
                ),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      pwCell('COMMENTAIRE', true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pwCell(ordre.commentaire, false),
                    ],
                  ),
                ],
              ),
              pw.Spacer(),
              pw.Table(
                border: pw.TableBorder.all(
                  width: 1,
                ),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      pwCell('VISA DEMANDEUR', true),
                      pwCell('VISA RESPONSABLE DE MAINTENANCE', true),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Expanded(child: pw.Container(height: 60)),
                      pw.Expanded(child: pw.Container(height: 60)),
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