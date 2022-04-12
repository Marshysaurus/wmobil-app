import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class PaymentsCard extends StatelessWidget {
  final double cash;
  final double card;
  final double voucher;
  final double other;
  final double tips;
  final double payed;

  const PaymentsCard({
    Key key,
    this.cash,
    this.card,
    this.voucher,
    this.other,
    this.tips,
    this.payed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(16),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(3, 2),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Métodos de Pago",
            style: wBlackCardHeader500,
          ),
          cash != null && cash != 0.0
              ? Row(
                  children: [
                    Text(
                      "Efectivo",
                      style: wGreenCardText700,
                    ),
                    Expanded(
                      child: CustomPaint(painter: DotsPainter()),
                    ),
                    Text(
                      "\$${currencyFormat.format(cash)}",
                      style: wBlackCardNormalText500,
                    ),
                    Text(
                      "MXN",
                      style: wBlackCardSubtext500,
                    ),
                  ],
                )
              : Container(),
          cash != null && cash != 0.0 ? SizedBox(height: 5) : Container(),
          card != null && card != 0.0
              ? Row(
                  children: [
                    Text(
                      "Tarjeta",
                      style: wGreenCardText700,
                    ),
                    Expanded(
                      child: CustomPaint(painter: DotsPainter()),
                    ),
                    Text(
                      "\$${currencyFormat.format(card)}",
                      style: wBlackCardNormalText500,
                    ),
                    Text(
                      "MXN",
                      style: wBlackCardSubtext500,
                    ),
                  ],
                )
              : Container(),
          card != null && card != 0.0 ? SizedBox(height: 5) : Container(),
          voucher != null && voucher != 0.0
              ? Row(
                  children: [
                    Text(
                      "Vales",
                      style: wGreenCardText700,
                    ),
                    Expanded(
                      child: CustomPaint(painter: DotsPainter()),
                    ),
                    Text(
                      "\$${currencyFormat.format(voucher)}",
                      style: wBlackCardNormalText500,
                    ),
                    Text(
                      "MXN",
                      style: wBlackCardSubtext500,
                    ),
                  ],
                )
              : Container(),
          voucher != null && voucher != 0.0 ? SizedBox(height: 5) : Container(),
          other != null && other != 0.0
              ? Row(
                  children: [
                    Text(
                      "Otros",
                      style: wGreenCardText700,
                    ),
                    Expanded(
                      child: CustomPaint(painter: DotsPainter()),
                    ),
                    Text(
                      "\$${currencyFormat.format(other)}",
                      style: wBlackCardNormalText500,
                    ),
                    Text(
                      "MXN",
                      style: wBlackCardSubtext500,
                    ),
                  ],
                )
              : Container(),
          other != null && other != 0.0
              ? SizedBox(
                  height: 5,
                )
              : Container(),
          tips != null && tips != 0.0
              ? Row(
                  children: [
                    Text(
                      "Propina",
                      style: wGreenCardText700,
                    ),
                    Expanded(
                      child: CustomPaint(painter: DotsPainter()),
                    ),
                    Text(
                      "\$${currencyFormat.format(tips)}",
                      style: wBlackCardNormalText500,
                    ),
                    Text(
                      "MXN",
                      style: wBlackCardSubtext500,
                    ),
                  ],
                )
              : Container(),
          tips != null && tips != 0.0
              ? SizedBox(
                  height: 5,
                )
              : Container(),
          Row(
            children: [
              Text(
                "Total",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(payed)}",
                style: wBlackCardNormalText500,
              ),
              Text(
                "MXN",
                style: wBlackCardSubtext500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
