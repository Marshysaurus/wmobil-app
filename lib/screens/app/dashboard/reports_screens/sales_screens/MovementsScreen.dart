import 'package:flutter/material.dart';
// External imports
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// Internal imports
import 'package:wmobil/constants/months.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/widgets/cards/ReportsCards/HighlightedPreviewCard.dart';
import 'package:wmobil/widgets/cards/RestaurantPreviewCard.dart';

class MovementsScreen extends StatefulWidget {
  final String restaurantName;
  MovementsScreen({this.restaurantName});

  @override
  _MovementsScreenState createState() => _MovementsScreenState();
}

class _MovementsScreenState extends State<MovementsScreen> {
  DateFormat dateFormat = DateFormat("yyyy/MM/dd HH:mm");

  List<pw.Widget> pdfWidgets = [pw.Header(level: 0, child: pw.Text('Cortes'))];

  List<dynamic> movimientos = [];

  DateTime startDate;
  DateTime endDate;

  String initialHourForQuery = '00:00:00';
  String initialDateQuery = '';
  String endHourForQuery = '23:59:59';
  String endDateQuery = '';

  String initialDateString = '';
  String endDateString = '';

  void showRangePicker() async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: startDate ?? (DateTime.now()).add(Duration(days: -7)),
        initialLastDate: endDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));
    if (picked != null) {
      if (picked.length == 1) {
        startDate = picked[0];
        endDate = picked[0];
        initialDateQuery = '${picked[0]}'
            .replaceAllMapped('-', (match) => '/')
            .substring(0, 10);
        initialDateString =
            '${picked[0].day} de ${months[picked[0].month]} de ${picked[0].year}';
        endDateQuery = initialDateQuery;
        endDateString = initialDateString;
        historicMovements.fetchHistoricMovements(
            initialDateQuery + " " + initialHourForQuery,
            endDateQuery + " " + endHourForQuery);
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
      if (picked.length == 2) {
        startDate = picked[0];
        endDate = picked[1];
        initialDateQuery = '${picked[0]}'
            .replaceAllMapped('-', (match) => '/')
            .substring(0, 10);
        initialDateString =
            '${picked[0].day} de ${months[picked[0].month]} de ${picked[0].year}';
        endDateQuery = '${picked[1]}'
            .replaceAllMapped('-', (match) => '/')
            .substring(0, 10);
        endDateString =
            '${picked[1].day} de ${months[picked[1].month]} de ${picked[1].year}';
        historicMovements.fetchHistoricMovements(
            initialDateQuery + " " + initialHourForQuery,
            endDateQuery + " " + endHourForQuery);
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
    }
  }

  void writeOnPdf(var infoCard) {
    pdfWidgets.add(
      pw.Table(
        columnWidths: {
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(1),
          2: pw.FlexColumnWidth(1),
          3: pw.FlexColumnWidth(1)
        },
        children: [
          pw.TableRow(
            children: [
              pw.Center(
                child: pw.Text(
                  infoCard["concepto"],
                  style: pwBlackColumnBody500,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  infoCard["operacion"],
                  style: pwBlackColumnBody500,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  dateFormat.format(DateTime.parse(infoCard["fecha"])),
                  style: pwBlackColumnBody500,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  double.parse(
                          (infoCard["importe"] as String).replaceAll(',', '.'))
                      .toStringAsFixed(2),
                  style: pwBlackColumnBody500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void writeTotalOnPdf({
    num totalizadorDeDepositos,
    num totalizadorDeRetiros,
  }) {
    pdfWidgets.add(pw.Container(height: 20));
    pdfWidgets.add(
      pw.Table(
        columnWidths: {
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(1),
        },
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColor.fromHex('#5BAC43'),
              ),
              color: PdfColor.fromHex('#5BAC43'),
            ),
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.Center(
                child: pw.Text(
                  "Total de\nDepósitos",
                  style: pwWhiteColumnHeader700,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  "Total de\nRetiros",
                  style: pwWhiteColumnHeader700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    pdfWidgets.add(
      pw.Table(
        columnWidths: {
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(1),
        },
        children: [
          pw.TableRow(
            children: [
              pw.Center(
                child: pw.Text(
                  "\$" + totalizadorDeDepositos.toStringAsFixed(2),
                  style: pwBlackColumnBody500,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  "\$" + totalizadorDeRetiros.toStringAsFixed(2),
                  style: pwBlackColumnBody500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void buildPDF(int tableDataLength) async {
    final doc = pw.Document();

    final baseFont = await rootBundle.load('fonts/Raleway/Raleway-Regular.ttf');
    final boldFont = await rootBundle.load('fonts/Raleway/Raleway-Bold.ttf');

    final logoImage = pw.MemoryImage(
        (await rootBundle.load('assets/logo.jpg')).buffer.asUint8List());

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
                    'Resumen de movimientos en ventas',
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
    // bool areDatesNotChosen = startDate == null || endDate == null;
    int initialDateLastFourDigits = initialDateString.length - 4;
    int endDateLastFourDigits = endDateString.length - 4;

    return Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: showRangePicker,
                        child: Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(3, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fecha Inicial",
                                style: wGreenCardText700,
                              ),
                              SizedBox(height: 5),
                              startDate != null
                                  ? Text(
                                      initialDateString.substring(
                                          0, initialDateLastFourDigits),
                                      style: wGreyCardNormalText500,
                                    )
                                  : Container(),
                              startDate != null
                                  ? Text(
                                      initialDateString
                                          .substring(initialDateLastFourDigits),
                                      style: wBlackCardNormalText500,
                                    )
                                  : Container(),
                              startDate == null
                                  ? Text("Sin seleccionar")
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: showRangePicker,
                        child: Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(3, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fecha Final",
                                style: wGreenCardText700,
                              ),
                              SizedBox(height: 5),
                              endDate != null
                                  ? Text(
                                      endDateString.substring(
                                          0, endDateLastFourDigits),
                                      style: wGreyCardNormalText500,
                                    )
                                  : Container(),
                              endDate != null
                                  ? Text(
                                      endDateString
                                          .substring(endDateLastFourDigits),
                                      style: wBlackCardNormalText500,
                                    )
                                  : Container(),
                              endDate == null
                                  ? Text("Sin seleccionar")
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              StreamBuilder(
                  stream: historicMovements.stream$,
                  builder: (context, snapshot) {
                    pdfWidgets.clear();
                    pdfWidgets.add(pw.SizedBox(height: 20));
                    pdfWidgets.add(
                      pw.Table(
                        columnWidths: {
                          0: pw.FlexColumnWidth(1),
                          1: pw.FlexColumnWidth(1),
                          2: pw.FlexColumnWidth(1),
                          3: pw.FlexColumnWidth(1)
                        },
                        children: [
                          pw.TableRow(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColor.fromHex('#5BAC43'),
                              ),
                              color: PdfColor.fromHex('#5BAC43'),
                            ),
                            verticalAlignment:
                                pw.TableCellVerticalAlignment.middle,
                            repeat: true,
                            children: [
                              pw.Center(
                                child: pw.Text(
                                  "Concepto",
                                  style: pwWhiteColumnHeader700,
                                ),
                              ),
                              pw.Center(
                                child: pw.Text(
                                  "Operación",
                                  style: pwWhiteColumnHeader700,
                                ),
                              ),
                              pw.Center(
                                child: pw.Text(
                                  "Fecha",
                                  style: pwWhiteColumnHeader700,
                                ),
                              ),
                              pw.Center(
                                child: pw.Text(
                                  "Importe*",
                                  style: pwWhiteColumnHeader700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );

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

                    if (snapshot?.data["reporte"] == null)
                      return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .1),
                        child: Text(snapshot.data["feedback"],
                            style: wTextStyle500),
                      );

                    movimientos = snapshot.data["reporte"].map((movement) {
                      return movement;
                    }).toList();

                    if (movimientos.isEmpty) {
                      return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .1),
                        child: Text("No hay información disponible...",
                            style: wTextStyle500),
                      );
                    } else {
                      // List<Widget> cardsList = movimientos.map((movimiento) {
                      //   return MovementCard(movement: movimiento);
                      // }).toList();

                      for (var movimiento in movimientos)
                        writeOnPdf(movimiento);

                      writeTotalOnPdf(
                        totalizadorDeDepositos: snapshot.data["totalizadorDepositos"],
                        totalizadorDeRetiros: snapshot.data["totalizadorRetiros"],
                      );

                      return Column(
                        children: [
                          HighlightedPreviewCard(
                            cardData: snapshot.data["totalizadorDepositos"],
                            cardInformationData: "Total Depósito",
                            backgroundColor: 0xFFEFF7EC,
                          ),
                          SizedBox(height: 8),
                          HighlightedPreviewCard(
                            cardData: snapshot.data["totalizadorRetiros"],
                            cardInformationData: "Total Retiro",
                            backgroundColor: 0xFFF7ECEC,
                            titleColor: 0xFFBD0900,
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
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
                    buildPDF(movimientos.length);
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
