import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// External imports
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/widgets/cards/ReportsCards/FiscalLogCards/LogCard.dart';
import 'package:wmobil/widgets/cards/RestaurantPreviewCard.dart';

class FiscalLogScreen extends StatefulWidget {
  final String restaurantName;
  FiscalLogScreen({this.restaurantName});

  @override
  _FiscalLogScreenState createState() => _FiscalLogScreenState();
}

class _FiscalLogScreenState extends State<FiscalLogScreen> {
  DateFormat dateFormat = DateFormat("yyyy/MM/dd HH:mm");

  List<pw.Widget> pdfWidgets = [
    pw.Header(level: 0, child: pw.Text('Bitácora Fiscal'))
  ];

  List<dynamic> rows = [];

  void writeOnPdf(var infoCard) async {
    pdfWidgets.add(
      pw.Table(
        columnWidths: {
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(2),
          2: pw.FlexColumnWidth(2),
          3: pw.FlexColumnWidth(2),
          4: pw.FlexColumnWidth(1),
          5: pw.FlexColumnWidth(1),
          6: pw.FlexColumnWidth(1),
          7: pw.FlexColumnWidth(1),
          8: pw.FlexColumnWidth(1)
        },
        children: [
          pw.TableRow(children: [
            pw.Center(
                child: pw.Text(
              infoCard["tipo"],
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              dateFormat.format(DateTime.parse(infoCard["fecha"])),
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              dateFormat.format(DateTime.parse(infoCard["fechainicial"])),
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              dateFormat.format(DateTime.parse(infoCard["fechafinal"])),
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              infoCard["cuentastotal"],
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              infoCard["cuentasmodificadas"],
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              double.parse(
                      '${infoCard["importeanterior"]}'.replaceAll(',', '.'))
                  .toStringAsFixed(2),
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              double.parse('${infoCard["importenuevo"]}'.replaceAll(',', '.'))
                  .toStringAsFixed(2),
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              double.parse('${infoCard["diferencia"]}'.replaceAll(',', '.'))
                  .toStringAsFixed(2),
              style: pwBlackColumnBody500,
            ))
          ]),
        ],
      ),
    );
  }

  void buildPDF(int tableDataLength) async {
    final doc = pw.Document();

    final baseFont = await rootBundle.load('fonts/Raleway/Raleway-Regular.ttf');
    final boldFont = await rootBundle.load('fonts/Raleway/Raleway-Bold.ttf');

    final logoImage = pw.MemoryImage((await rootBundle.load('assets/logo.jpg')).buffer.asUint8List());

    if (pdfWidgets.length < (4 + tableDataLength))
      pdfWidgets.insert(
        0,
        pw.Header(
          // decoration: pw.BoxDecoration(
          //   border: pw.BoxBorder(bottom: false),
          // ),
          child: pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    widget.restaurantName,
                    style: pwGreenRestaurantTitle700,
                  ),
                  pw.Row(
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Reporte generado',
                              style: pwGreenText700,
                            ),
                            pw.Text(
                              'con WMobil',
                              style: pwGreenText700,
                            ),
                          ]),
                      pw.SizedBox(width: 10),
                      pw.ClipRect(
                        child: pw.Container(
                          height: 40,
                          width: 40,
                          child: pw.Image(logoImage),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Bitácora Fiscal',
                    style: pwBlackDocumentType500,
                  ),
                  pw.Text(
                    'Todos los datos son en pesos mexicanos*',
                    style: pwBlackAdMessage500,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.standard,
          orientation: pw.PageOrientation.landscape,
          theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(baseFont),
            bold: pw.Font.ttf(boldFont),
          ),
        ),
        build: (pw.Context context) {
          return pdfWidgets;
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (pageFormat) async => doc.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: fiscalLog.stream$,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            pdfWidgets.clear();
            pdfWidgets.add(pw.SizedBox(height: 20));
            pdfWidgets.add(pw.Table(columnWidths: {
              0: pw.FlexColumnWidth(1),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(2),
              3: pw.FlexColumnWidth(2),
              4: pw.FlexColumnWidth(1),
              5: pw.FlexColumnWidth(1),
              6: pw.FlexColumnWidth(1),
              7: pw.FlexColumnWidth(1),
              8: pw.FlexColumnWidth(1)
            }, children: [
              pw.TableRow(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                          color: PdfColor.fromHex('#5BAC43'))),
                  verticalAlignment: pw.TableCellVerticalAlignment.middle,
                  repeat: true,
                  children: [
                    pw.Center(
                        child: pw.Text(
                      "Tipo",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Fecha",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Fecha inicial",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Fecha final",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Cuentas",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Modif",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Importe anterior",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Importe nuevo",
                      style: pwWhiteColumnHeader700,
                    )),
                    pw.Center(
                        child: pw.Text(
                      "Difer",
                      style: pwWhiteColumnHeader700,
                    ))
                  ]),
            ]));

            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot?.data["loading"])
              return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .1),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(53, 175, 46, 1)),
                ),
              );

            if (snapshot?.data["rows"] == null)
              return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .1),
                child: Text(snapshot.data["feedback"], style: wTextStyle500),
              );

            rows = snapshot.data["rows"].map((row) {
              return row;
            }).toList();

            if (rows.isEmpty) {
              return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .1),
                child: Text("No hay información disponible...",
                    style: wTextStyle500),
              );
            } else {
              List<Widget> cardsList = rows.map((row) {
                return LogCard(row: row);
              }).toList();

              for (var row in rows) writeOnPdf(row);

              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: rows.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == rows.length)
                      return Container(height: 100);

                    return cardsList[index];
                  });
            }
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(
              bottom: 24,
              right: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Generar PDF",
                  style: wGreenButtonText500,
                ),
                SizedBox(height: 5),
                RawMaterialButton(
                  onPressed: () {
                    buildPDF(rows.length);
                  },
                  fillColor: Color(0xFF5BAC43),
                  padding: EdgeInsets.all(15),
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.print_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
