import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/Categories/ReportCategories.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/models/Restaurant.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

typedef void ReportCategoryCallback(ReportCategory val);

class GeneralDataCard extends StatefulWidget {
  final RestaurantModel restaurantModel;
  final bool isFiscalLogVisible;
  final double number;
  final int tablesOpen;
  final DateTime lastFetched;
  final int cancellations;
  final int items;
  final int people;
  final ReportCategory currentReportCategory;
  final ReportCategoryCallback callback;

  const GeneralDataCard({
    Key key,
    this.restaurantModel,
    this.isFiscalLogVisible,
    this.number,
    this.tablesOpen,
    this.lastFetched,
    this.cancellations,
    this.items,
    this.people,
    this.currentReportCategory,
    this.callback,
  }) : super(key: key);

  @override
  _GeneralDataCardState createState() => _GeneralDataCardState();
}

class _GeneralDataCardState extends State<GeneralDataCard> {
  List<ReportCategory> reportCategories;

  Widget overlapped() {
    final overlap = 14.0;
    final icons = [
      Icon(
        Icons.receipt,
        size: 18,
      ),
      ClipOval(
        child: Container(
            child: Icon(
              Icons.cancel,
              size: 10,
              color: Colors.red,
            ),
            color: Colors.white),
      )
    ];

    List<Widget> stackLayers = List<Widget>.generate(icons.length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
        child: icons[index],
      );
    });

    return Stack(alignment: Alignment.bottomCenter, children: stackLayers);
  }

  @override
  void initState() {
    super.initState();
    widget.isFiscalLogVisible
        ? reportCategories = [
            ReportCategory.ventas,
            ReportCategory.descuentos,
            ReportCategory.cancelaciones,
            // ReportCategory.produccion,
            // ReportCategory.asistencias,
            ReportCategory.bitacoraFiscal,
          ]
        : reportCategories = [
            ReportCategory.ventas,
            ReportCategory.descuentos,
            ReportCategory.cancelaciones,
            // ReportCategory.produccion,
            // ReportCategory.asistencias,
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
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
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            Text("\$", style: wNumberStyle700),
            Text(
                currencyFormat.format(widget.restaurantModel != null
                    ? widget.restaurantModel.number
                    : widget.number),
                style: wNumberStyle700),
            Text(
              "MXN",
              style: wGreenSubtext700,
            ),
            Spacer(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text(
            //       "Última actualización",
            //       style: wGreyHint500,
            //     ),
            //     Text(
            //       "${format.format(widget.restaurantModel != null ? widget.restaurantModel.lastFetched : widget.lastFetched)}",
            //       style: wBlackLastUpdate400,
            //     ),
            //   ],
            // )
          ]),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return reportCategories.map<PopupMenuItem<ReportCategory>>(
                      (ReportCategory value) {
                    return PopupMenuItem<ReportCategory>(
                      value: value,
                      child: Text(
                        value.text,
                        style: wBlackOptionSelection500,
                      ),
                    );
                  }).toList();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.currentReportCategory.text,
                      style: wBlackOptionSelection500,
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                onSelected: (ReportCategory newValue) {
                  widget.callback(newValue);
                },
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.restaurantModel != null ? widget.restaurantModel.cancellations : widget.cancellations}",
                        style: wBlackOptionSelection500,
                      ),
                      overlapped()
                    ],
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        "${widget.restaurantModel != null ? widget.restaurantModel.items : widget.items}",
                        style: wBlackOptionSelection500,
                      ),
                      Icon(Icons.fastfood, size: 18),
                    ],
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        "${widget.restaurantModel != null ? widget.restaurantModel.people : widget.people}",
                        style: wBlackOptionSelection500,
                      ),
                      Icon(Icons.people),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
