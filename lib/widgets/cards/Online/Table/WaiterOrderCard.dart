import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class WaiterOrderCard extends StatelessWidget {
  final String waiter;

  WaiterOrderCard({Key key, this.waiter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(16),
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
          waiter != null ? Text(
            "Atendió:",
            style: wBlackCardHeader500,
          ) : Container(),
          waiter != null ? SizedBox(height: 5) : Container(),
          Text(
            waiter ?? "Sin mesero",
            style: wGreenCardText700,
          ),
        ],
      ),
    );
  }
}
