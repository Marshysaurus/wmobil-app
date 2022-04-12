import 'dart:io';

import 'package:flutter/material.dart';
// External imports
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// Internal imports
import 'package:wmobil/widgets/cards/ReportsCards/SalesCards/WaiterCard.dart';
import 'package:wmobil/widgets/cards/RestaurantPreviewCard.dart';

class WaitersScreen extends StatefulWidget {
  final String restaurantName;
  WaitersScreen({this.restaurantName});

  @override
  _WaitersScreenState createState() => _WaitersScreenState();
}

class _WaitersScreenState extends State<WaitersScreen> {
  final doc = pw.Document();

  List<pw.Widget> pdfWidgets = [pw.Header(level: 0, child: pw.Text('Cortes'))];

  Directory documentDirectory;
  String docPath;
  String datePath;

  String hourForQuery = '06:00:00 AM';
  String initialDateQuery = '';
  String endDateQuery = '';

  void showRangePicker() async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        initialLastDate: (DateTime.now()).add(Duration(days: 7)),
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));
    if (picked != null && picked.length == 2) {
      setState(() {
        // if (TimeOfDay.now().format(context).length == 7)
        //   hourForQuery = '0' + TimeOfDay.now().format(context) + ":00";
        // else
        //   hourForQuery = TimeOfDay.now().format(context) + ":00";
        initialDateQuery = '${picked[0]}'
            .replaceAllMapped('-', (match) => '/')
            .substring(0, 10);
        endDateQuery = '${picked[1]}'
            .replaceAllMapped('-', (match) => '/')
            .substring(0, 10);
      });
    }
  }

  void writeOnPdf(var infoCard) {
    pw.TextStyle pwStyle400 = pw.TextStyle(
        fontWeight: pw.FontWeight.normal,
        fontSize: 16,
        color: PdfColor.fromHex('#212121'));

    pw.TextStyle pwStyle500 = pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 18,
        color: PdfColor.fromHex('#4A4A4A'));

    pdfWidgets.add(pw.Container(
        margin: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: pw.EdgeInsets.all(20),
        decoration: pw.BoxDecoration(
          color: PdfColor.fromHex('#FFFFFF'),
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(5)),
        ),
        child: pw.Column(
          children: <pw.Widget>[
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  child: pw.Text("ID:", style: pwStyle500),
                  margin: pw.EdgeInsets.only(right: 5),
                ),
                pw.Container(
                  child: pw.Text(
                      '${infoCard["idmesero"]}'
                          .replaceAllMapped('T', (match) => ' ')
                          .replaceAll('.000Z', ''),
                      style: pwStyle400),
                  margin: pw.EdgeInsets.only(right: 5),
                ),
              ],
            ),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  child: pw.Text("Nombre:", style: pwStyle500),
                  margin: pw.EdgeInsets.only(right: 5),
                ),
                pw.Container(
                  child: pw.Text('${infoCard["nombre"]}', style: pwStyle400),
                  margin: pw.EdgeInsets.only(right: 5),
                ),
              ],
            ),
          ],
        )));
  }

  void generatePath() async {
    documentDirectory = await getTemporaryDirectory();
    setState(() {
      docPath = documentDirectory.path;
    });
  }

  Future savePdf(String path) async {
    datePath = DateTime.now().toString();

    doc.addPage(pw.MultiPage(
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
      return pdfWidgets;
    }));
    File file = File("$path/reporte_movs_$datePath.pdf");
    file.writeAsBytesSync(await doc.save());
  }

  @override
  void initState() {
    generatePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                        onPressed: showRangePicker,
                        child: Text("Elige el rango de fechas")),
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      historicWaiters.fetchHistoricWaiters(
                          initialDateQuery + " " + hourForQuery,
                          endDateQuery + " " + hourForQuery);
                      Future.delayed(Duration(milliseconds: 500), () {
                        setState(() {});
                      });
                    },
                    child: Text('Buscar'),
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder(
            stream: historicWaiters.stream$,
            builder: (context, snapshot) {
              pdfWidgets.clear();
              pdfWidgets.add(pw.Header(level: 0, text: 'WMobil'));
              pdfWidgets.add(pw.Text('Reporte de Meseros',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)));
              pdfWidgets.add(pw.SizedBox(height: 20));
              pdfWidgets.add(pw.Table(border: pw.TableBorder(), columnWidths: {
                0: pw.FlexColumnWidth(3),
                1: pw.FlexColumnWidth(3),
                2: pw.FlexColumnWidth(2),
                3: pw.FlexColumnWidth(2),
                4: pw.FlexColumnWidth(2),
                5: pw.FlexColumnWidth(2),
                6: pw.FlexColumnWidth(2),
                7: pw.FlexColumnWidth(2),
              }, children: [
                pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    repeat: true,
//                    decoration: pw.BoxDecoration(
//                      color: PdfColor.fromHex('#C0C0C0'),
//                    ),
                    children: [
                      pw.Text("APERTURA"),
                      pw.Text("CIERRE"),
                      pw.Container(child: pw.Text("IMPORTE TOTAL")),
                      pw.Text("IMPORTE SIN IVA"),
                      pw.Text("EFECTIVO"),
                      pw.Text("TARJETA"),
                      pw.Text("VALES"),
                      pw.Text("OTROS")
                    ]),
              ]));
              if (snapshot.data == null || snapshot.data["loading"])
                return Container();
              List<dynamic> meseros = snapshot.data["meseros"].map((movement) {
                return movement;
              }).toList();
              if (meseros.isEmpty) {
                return Container();
              }
              for (var mesero in meseros) writeOnPdf(mesero);
              return Column(
                children: meseros.map<Widget>((mesero) {
                  return WaiterCard(
                      waiter: mesero,
                      startDate: initialDateQuery + " " + hourForQuery,
                      endDate: endDateQuery + " " + hourForQuery);
                }).toList(),
              );
            }),
      ],
    );
  }
}
