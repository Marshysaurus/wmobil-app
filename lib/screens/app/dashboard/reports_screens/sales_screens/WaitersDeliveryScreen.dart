import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/widgets/cards/ReportsCards/SalesCards/DeliveryCard.dart';
import 'package:wmobil/widgets/cards/ReportsCards/SalesCards/WaiterCard.dart';

class WaitersDeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          hoverColor: Colors.black,
          iconSize: 16,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Mesero', style: wTextStyleAppBar),
      ),
      body: StreamBuilder(
        stream: historicWaiter.stream$,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data["loading"])
            return Container();

          if (snapshot.data["reporte"].isEmpty) {
            return Container();
          }

          return ListView(
            children: snapshot.data["reporte"].map<Widget>((orden) {
              return DeliveryCard(delivery: orden);
            }).toList(),
          );
        },
      ),
    );
  }
}
