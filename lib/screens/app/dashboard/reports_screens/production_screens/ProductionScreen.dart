import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// External imports
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/widgets/cards/ReportsCards/ProductionProductsCards/ProductionProductCard.dart';
import 'package:wmobil/widgets/cards/RestaurantPreviewCard.dart';

class ProductionScreen extends StatefulWidget {
  final String restaurantName;
  ProductionScreen({this.restaurantName});

  @override
  _ProductionScreenState createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  DateFormat dateFormat = DateFormat("yyyy/MM/dd HH:mm");

  List<pw.Widget> pdfWidgets = [
    pw.Header(level: 0, child: pw.Text('Productos en Producción'))
  ];

  List<dynamic> rows = [];

  DateTime startDate;
  DateTime endDate;

  String initialHourForQuery = '00:00:00';
  String initialDateQuery = '';
  String endHourForQuery = '23:59:59';
  String endDateQuery = '';

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
        initialDateQuery =
            '${picked[0]}'.replaceAllMapped('-', (match) => '/').substring(0, 10);
        endDateQuery =
            '${picked[0]}'.replaceAllMapped('-', (match) => '/').substring(0, 10);
        productionProducts.fetchProductionProducts(
            initialDateQuery + " " + initialHourForQuery,
            endDateQuery + " " + endHourForQuery);
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
      if (picked.length == 2) {
        startDate = picked[0];
        endDate = picked[1];
        initialDateQuery =
            '${picked[0]}'.replaceAllMapped('-', (match) => '/').substring(0, 10);
        endDateQuery =
            '${picked[1]}'.replaceAllMapped('-', (match) => '/').substring(0, 10);
        productionProducts.fetchProductionProducts(
            initialDateQuery + " " + initialHourForQuery,
            endDateQuery + " " + endHourForQuery);
        Future.delayed(Duration.zero, () {
          setState(() {});
        });
      }
    }
  }

  void writeOnPdf(var infoCard) async {
    pdfWidgets.add(
      pw.Table(columnWidths: {
        0: pw.FlexColumnWidth(1),
        1: pw.FlexColumnWidth(1),
        2: pw.FlexColumnWidth(1),
        3: pw.FlexColumnWidth(1),
      }, children: [
        pw.TableRow(
          children: [
            pw.Center(
                child: pw.Text(
              infoCard["productodes"],
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              dateFormat.format(DateTime.parse(infoCard["hora"])),
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              dateFormat.format(DateTime.parse(infoCard["horaproduccion"])),
              style: pwBlackColumnBody500,
            )),
            pw.Center(
                child: pw.Text(
              infoCard["minutospreparacion"],
              style: pwBlackColumnBody500,
            )),
          ],
        )
      ]),
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
                    'Productos en producción',
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
    bool areDatesNotChosen = startDate == null || endDate == null;

    return Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      areDatesNotChosen
                          ? "Elige el rango de fechas"
                          : "$initialDateQuery al $endDateQuery",
                      style: wGreenProductCardTitle700,
                    ),
                    IconButton(
                      onPressed: showRangePicker,
                      icon: Icon(
                        Icons.date_range,
                        color: Color(0xFF5BAC43),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: productionProducts.stream$,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  pdfWidgets.clear();
                  pdfWidgets.add(pw.SizedBox(height: 20));
                  pdfWidgets.add(pw.Table(columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(1),
                    2: pw.FlexColumnWidth(1),
                    3: pw.FlexColumnWidth(1),
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
                                "Producto",
                                style: pwWhiteColumnHeader700,
                              )),
                          pw.Center(
                              child: pw.Text(
                                "Hora",
                                style: pwWhiteColumnHeader700,
                              )),
                          pw.Center(
                              child: pw.Text(
                                "Hora de producción",
                                style: pwWhiteColumnHeader700,
                              )),
                          pw.Center(
                              child: pw.Text(
                                "Minutos de preparación",
                                style: pwWhiteColumnHeader700,
                              )),
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

                  if (snapshot?.data["reporte"] == null)
                    return Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .1),
                      child: Text(snapshot.data["feedback"], style: wTextStyle500),
                    );

                  rows = snapshot.data["reporte"]["productos"].map((row) {
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
                      return ProductionProductCard(row: row);
                    }).toList();

                    for (var row in rows) writeOnPdf(row);

                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: rows.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == rows.length) return Container(height: 100);

                          return cardsList[index];
                        });
                  }
                },
              ),
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
