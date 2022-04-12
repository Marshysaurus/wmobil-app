import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';

final cardBackgroundColor = {
  1: Color(0xFFFFFCE0),
  2: Color(0xFFF3F3F3),
  3: Color(0xFFFFEDD2),
};

final cardTitleColor = {
  1: Color(0xFFCFAB10),
  2: Color(0xFFA3A3A3),
  3: Color(0xFFB0853D),
};

class TopProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  TopProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBackgroundColor[product["ranking"]] ?? Colors.white,
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
            '${product["descripcion"]}',
            style: product["ranking"] <= 3
                ? TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: cardTitleColor[product["ranking"]])
                : wGreenProductCardTitle700,
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${product["amount"]} Unidades',
                style: wBlackCardNormalText500,
              ),
              Spacer(),
              Text(
                '\$${product["total"]} ',
                style: wGreyTotalProductCard500,
              ),
              Text(
                'MXN',
                style: wGreyMXNProductCard500,
              )
            ],
          ),
        ],
      ),
    );
  }
}
