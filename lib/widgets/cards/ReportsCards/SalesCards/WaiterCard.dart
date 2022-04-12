import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/main.dart';
import 'package:wmobil/streams/Reports/SalesWaiter.dart';
import 'package:wmobil/streams/Restaurant.dart';

final restaurant = getIt.get<Restaurant>();
final historicWaiter = getIt.get<SalesWaiter>();

class WaiterCard extends StatelessWidget {
  final Map<String, dynamic> waiter;
  final String startDate;
  final String endDate;
  WaiterCard({this.waiter, this.startDate, this.endDate});

  void onTapWaiter(context, route) {
    historicWaiter.setWaiter(waiter['idmesero'], startDate, endDate);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapWaiter(context, '/reports/sales/waiter');
      },
      child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .18),
                    blurRadius: 5.0, // has the effect of softening the shadow
                    spreadRadius: 2.0, // has the effect of extending the shadow
                    offset: Offset(
                      2.0,
                      4.0,
                    ))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                textBaseline: TextBaseline.ideographic,
                children: <Widget>[
                  Container(
                    child: Text("ID mesero:", style: wTextStyle500),
                    margin: EdgeInsets.only(right: 5),
                  ),
                  Flexible(child: Text('${waiter["idmesero"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                textBaseline: TextBaseline.ideographic,
                children: <Widget>[
                  Container(
                    child: Text("Nombre:", style: wTextStyle500),
                    margin: EdgeInsets.only(right: 5),
                  ),
                  Flexible(child: Text('${waiter["nombre"]}', style: wTextStyle400, overflow: TextOverflow.ellipsis)),
                ],
              ),
            ],
          )),
    );
  }
}
