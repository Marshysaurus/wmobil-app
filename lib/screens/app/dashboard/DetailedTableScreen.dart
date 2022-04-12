import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/streams/TableStream.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';
import 'package:wmobil/widgets/cards/Online/Table/Accounts/DetailedAccountCard.dart';
import 'package:wmobil/widgets/cards/Online/Table/DetailedProductCard.dart';
import 'package:wmobil/widgets/cards/Online/Table/WaiterOrderCard.dart';

GetIt getIt = GetIt.instance;
final NumberFormat currencyFormat =
    new NumberFormat.simpleCurrency(decimalDigits: 2);
// final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");

class DetailedTableScreen extends StatefulWidget {
  final String restaurantName;
  final DateTime lastFetched;
  final int folio;
  final bool isOpen;
  DetailedTableScreen(
      {Key key, this.restaurantName, this.lastFetched, this.folio, this.isOpen})
      : super(key: key);

  @override
  _DetailedTableScreenState createState() => _DetailedTableScreenState();
}

class _DetailedTableScreenState extends State<DetailedTableScreen> {
  final tableStream = getIt.get<TableStream>();
  bool isPanelExpanded = false;

  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();

    return StreamBuilder<Object>(
        stream: tableStream.stream$,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || snapshot.data["loading"]) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 14),
                      Text(
                        widget.restaurantName,
                        style: wWhiteSubtitle500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                !widget.isOpen
                    ? Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          'Folio ${widget.folio}',
                          style: wWhiteTitle700,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(""),
                      ),
                SizedBox(height: 20),
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(53, 175, 46, 1)),
                  ),
                )
              ],
            );
          }

          var table = snapshot.data;

          return SlidingUpPanel(
            controller: panelController,
            maxHeight: MediaQuery.of(context).size.height * .6,
            minHeight: MediaQuery.of(context).size.height * .1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(20),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            onPanelOpened: () {
              setState(() {
                isPanelExpanded = true;
              });
            },
            onPanelClosed: () {
              setState(() {
                isPanelExpanded = false;
              });
            },
            panel: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: !isPanelExpanded
                      ? Icon(Icons.keyboard_arrow_up_rounded)
                      : Icon(Icons.remove),
                ),
                Text(
                  "Detalle de cuenta",
                  style: wBlackCardHeader500,
                ),
                slideUpPanelRow(
                  "Total",
                  double.parse(table["tarjeta"]) +
                      double.parse(table["efectivo"]) +
                      double.parse(table["vales"]) +
                      double.parse(table["otros"]) +
                      double.parse(table["propina"]),
                ),
                slideUpPanelRow("Subtotal",
                    double.parse(table["subtotal"].replaceAll(',', '.'))),
                slideUpPanelRow(
                    "Impuestos",
                    double.parse(table["totalconpropina"]) -
                        double.parse(table["subtotal"].replaceAll(',', '.'))),
                slideUpPanelRow("Propina", double.parse(table["propina"])),
                SizedBox(height: 20),
                Text(
                  "Formas de pago",
                  style: wBlackCardHeader500,
                ),
                slideUpPanelRow("Efectivo", double.parse(table["efectivo"])),
                slideUpPanelRow(
                    "Tarjeta de crédito", double.parse(table["tarjeta"])),
                slideUpPanelRow("Vales", double.parse(table["vales"])),
                slideUpPanelRow("Otros", double.parse(table["otros"])),
                SizedBox(height: 20),
                Text(
                  "Descuentos y cancelaciones",
                  style: wBlackCardHeader500,
                ),
                slideUpPanelRow(
                    "Total cortesías", double.parse(table["totalcortesias"])),
                slideUpPanelRow(
                    "Total descuentos", double.parse(table["totaldescuentos"])),
                slideUpPanelRow("Descuento", double.parse(table["descuento"]),
                    prepend: "%"),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 14),
                      Text(
                        widget.restaurantName,
                        style: wWhiteSubtitle500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                !widget.isOpen
                    ? Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    'Folio ${widget.folio}',
                    style: wWhiteTitle700,
                  ),
                )
                    : Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(""),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        DetailedAccountCard(
                          table: table,
                        ),
                        SizedBox(height: 16),
                        WaiterOrderCard(waiter: table["nombre"]),
                        // SizedBox(height: 8),
                        // PaymentsCard(
                        //   card: double.parse(table["tarjeta"]),
                        //   cash: double.parse(table["efectivo"]),
                        //   voucher: double.parse(table["vales"]),
                        //   other: double.parse(table["otros"]),
                        //   tips: double.parse(table["propina"]),
                        //   payed: double.parse(table["tarjeta"]) +
                        //       double.parse(table["efectivo"]) +
                        //       double.parse(table["vales"]) +
                        //       double.parse(table["otros"]) +
                        //       double.parse(table["propina"]),
                        // ),
                        // SizedBox(height: 8),
                        // ProductsCard(
                        //   drinkRevenue: double.parse(table["totalbebidas"]),
                        //   foodRevenue: double.parse(
                        //       (table["totalalimentos"] as String)
                        //           .replaceAll(',', '.')),
                        // ),
                        SizedBox(height: 4),
                        for (var product in table["products"])
                          DetailedProductCard(product: product),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });

    // return Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       elevation: 0.0,
    //       backgroundColor: Colors.white,
    //       centerTitle: true,
    //       leading: IconButton(
    //         hoverColor: Colors.black,
    //         iconSize: 16,
    //         icon: Icon(
    //           Icons.arrow_back,
    //           color: Colors.black,
    //         ),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       title: Text("Mesa (Online)",
    //           style: TextStyle(
    //               fontWeight: FontWeight.w700,
    //               fontSize: 18,
    //               letterSpacing: -.02,
    //               color: Color.fromRGBO(33, 33, 33, 1))),
    //     ),
    //     body:
  }

  Widget slideUpPanelRow(String field, dynamic value, {String prepend}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            field,
            style: wGreenCardText700,
          ),
          Expanded(
            child: CustomPaint(painter: DotsPainter()),
          ),
          prepend != null
              ? Text(
                  "$value",
                  style: wBlackCardNormalText500,
                )
              : Text(
                  "${currencyFormat.format(value)}",
                  style: wBlackCardNormalText500,
                ),
          Text(
            prepend != null ? "%" : "MXN",
            style: wBlackCardSubtext500,
          ),
        ],
      ),
    );
  }
}
