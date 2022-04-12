import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/models/Restaurant.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class EarningsCard extends StatelessWidget {
  final RestaurantModel restaurantModel;
  final double number;
  final int tablesOpen;
  final DateTime lastFetched;
  final int cancellations;
  final int items;
  final int people;

  const EarningsCard({
    Key key,
    this.restaurantModel,
    this.number,
    this.tablesOpen,
    this.lastFetched,
    this.cancellations,
    this.items,
    this.people,
  }) : super(key: key);

  Widget overlapped() {
    final overlap = 16.0;
    final icons = [
      Icon(
        Icons.receipt,
        size: 18,
      ),
      ClipOval(
        child: Container(
            child: Icon(
              Icons.cancel,
              size: 12,
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
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: <Widget>[
                      Container(
                        child: Text("\$", style: wNumberStyle700),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Container(
                        child: Text(
                            currencyFormat.format(restaurantModel != null
                                ? restaurantModel.number
                                : number),
                            style: wNumberStyle700),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Text(
                        "MXN",
                        style: wGreenSubtext700,
                      ),
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       "Última actualización",
                  //       style: wGreyHint500,
                  //     ),
                  //     Text(
                  //       "${format.format(restaurantModel != null ? restaurantModel.lastFetched : lastFetched)}",
                  //       style: wBlackLastUpdate400,
                  //     ),
                  //   ],
                  // )
                ]),
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                  "${restaurantModel != null ? restaurantModel.tablesOpen : tablesOpen} cuentas abiertas",
                  style: wBlackOptionSelection500),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "${restaurantModel != null ? restaurantModel.cancellations : cancellations}",
                        style: wBlackOptionSelection500,
                      ),
                      overlapped()
                    ],
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        "${restaurantModel != null ? restaurantModel.items : items}",
                        style: wBlackOptionSelection500,
                      ),
                      Icon(Icons.fastfood, size: 18),
                    ],
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Text(
                        "${restaurantModel != null ? restaurantModel.people : people}",
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
