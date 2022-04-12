import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DotsPainter.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");

class PaymentMethodsCard extends StatelessWidget {
  final List<dynamic> paymentMethod;

  const PaymentMethodsCard({Key key, this.paymentMethod}) : super(key: key);

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
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Métodos de Pago",
            style: wBlackCardHeader500,
          ),
          SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: paymentMethod.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Text(
                    "${paymentMethod[index]["descripcion"]}",
                    style: wGreenCardText700,
                  ),
                  Expanded(
                    child: CustomPaint(
                      painter: DotsPainter(),
                    ),
                  ),
                  Text(
                    "\$${currencyFormat.format(double.parse("${paymentMethod[index]["precio"]}"))}",
                    style: wBlackCardNormalText500,
                  ),
                  Text(
                    "MXN",
                    style: wBlackCardSubtext500,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
