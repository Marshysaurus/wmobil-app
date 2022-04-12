import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';
//import 'package:wmobil/models/Restaurant.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class DiscountsAndCancellationsCard extends StatelessWidget {
//  final double discountsInFood;
//  final double discountsInDrinks;
  final double discounts;
  final double tableCancellations;
  final double discountsPerProduct;
  final double discountsPerAccount;
  final double cancellationsPerProduct;
  final double cancellationsPerAccount;
  final int productCancellations;

  const DiscountsAndCancellationsCard({
    Key key,
//    this.discountsInFood,
//    this.discountsInDrinks,
    this.discounts,
    this.tableCancellations,
    this.discountsPerProduct,
    this.discountsPerAccount,
    this.cancellationsPerProduct,
    this.cancellationsPerAccount,
    this.productCancellations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
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
          Text(
            "Descuentos y cancelaciones",
            style: wBlackCardHeader500,
          ),
          //                  Container(
//                      child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Container(
//                        child: Text(
//                          "Descuentos en alimentos:",
//                          style: wTextStyle300,
//                        ),
//                      ),
//                      Container(
//                          child: Text(
//                        "\$ ${currencyFormat.format(discountsInFood)} MXN",
//                        style: wTextStyle400,
//                      )),
//                    ],
//                  )),
//                  SizedBox(
//                    height: 5,
//                  ),
//                  Container(
//                      child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Container(
//                        child: Text(
//                          "Descuentos en bebidas:",
//                          style: wTextStyle300,
//                        ),
//                      ),
//                      Container(
//                          child: Text(
//                        "\$ ${currencyFormat.format(discountsInDrinks)} MXN",
//                        style: wTextStyle400,
//                      )),
//                    ],
//                  )),
//                  SizedBox(
//                    height: 5,
//                  ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Descuentos por productos",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(discountsPerProduct)}",
                style: wBlackCardNormalText500,
              ),
              Text(
                "MXN",
                style: wBlackCardSubtext500,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Descuentos por cuenta",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(discountsPerAccount)}",
                style: wBlackCardNormalText500,
              ),
              Text(
                "MXN",
                style: wBlackCardSubtext500,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Cancelaciones por productos",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(cancellationsPerProduct)}",
                style: wBlackCardNormalText500,
              ),
              Text(
                "MXN",
                style: wBlackCardSubtext500,
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Cancelaciones por cuenta",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(cancellationsPerAccount)}",
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
