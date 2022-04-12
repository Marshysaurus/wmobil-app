import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';

class RegularProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  RegularProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
          Text(
            '${product["descripcion"]}',
            style: wGreenProductCardTitle700,
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
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
          Text(
            '${product["amount"]} Unidades',
            style: wBlackCardNormalText500,
          ),
        ],
      ),
    );
  }
}
