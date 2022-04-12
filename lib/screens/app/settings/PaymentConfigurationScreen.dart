import 'package:flutter/material.dart';

// Internal imports
import 'package:wmobil/widgets/tiles/tiles.dart';

class PaymentConfigurationScreen extends StatelessWidget {
  const PaymentConfigurationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: new IconButton(
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
          centerTitle: true,
          title: Text("Configuración de pago",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: -.02,
                  color: Color.fromRGBO(33, 33, 33, 1))),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: ListView(children: <Widget>[
                  Container(
                    child: InformationTile(
                      title: "Válido hasta: 05/03/20",
                    ),
                  ),
                  Container(
                    child: LinkTile(
                      icon: Icons.credit_card,
                      title: "•••• 4417",
                    ),
                  ),
                ]))
              ],
            ),
          ),
        ));
  }
}
