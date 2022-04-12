import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class ProductsCard extends StatelessWidget {
  final double foodRevenue;
  final double drinkRevenue;

  const ProductsCard({Key key, this.foodRevenue, this.drinkRevenue})
      : super(key: key);

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
            "Venta por tipo de producto (Sin IVA)",
            style: wBlackCardHeader500,
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Alimentos",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(painter: DotsPainter()),
              ),
              Text(
                "\$${currencyFormat.format(foodRevenue)}",
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
                "Bebidas",
                style: wGreenCardText700,
              ),
              Expanded(
                child: CustomPaint(
                  painter: DotsPainter(),
                ),
              ),
              Text(
                "\$${currencyFormat.format(drinkRevenue)}",
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
