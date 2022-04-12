import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class DetailedAccountCard extends StatelessWidget {
  final dynamic table;

  DetailedAccountCard({Key key, this.table})
      : super(key: key);

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '\$${currencyFormat.format(double.parse(table["totalconpropina"]))}',
                style: wNumberStyle700,
              ),
              Text(
                "MXN",
                style: wGreenSubtext700,
              ),
              // Spacer(),
              // lastFetched != null
              //     ? Column(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           Text(
              //             "Última actualización",
              //             style: wGreyHint500,
              //           ),
              //           Text(
              //             "${format.format(lastFetched)}",
              //             style: wBlackLastUpdate400,
              //           ),
              //         ],
              //       )
              //     : Container(),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              table["cierre"] != null
                  ? Text(
                      "Cierre: ${format.format(DateTime.parse(table["cierre"]).toLocal())}",
                      style: wBlackOptionSelection500,
                    )
                  : Container(),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${table["totalarticulos"]}",
                    style: wBlackCardNormalText500,
                  ),
                  Icon(
                    Icons.fastfood,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "${table["nopersonas"]}",
                    style: wBlackCardNormalText500,
                  ),
                  Icon(
                    Icons.people,
                    size: 20,
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
