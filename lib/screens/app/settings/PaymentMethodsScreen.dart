import 'package:flutter/material.dart';

// External imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/streams/PaymentMethods.dart';

// Internal imports

GetIt getIt = GetIt.instance;

class PaymentMethodsScreen extends StatelessWidget {
  PaymentMethodsScreen({Key key}) : super(key: key);

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
          title: Text("Mis métodos de pago",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: -.02,
                  color: Color.fromRGBO(33, 33, 33, 1))),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[Container(child: PaymentMethodList())],
            ),
          ),
        ));
  }
}

class PaymentMethodList extends StatelessWidget {
  final paymentMethods = getIt.get<PaymentMethods>();

  PaymentMethodList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: paymentMethods.stream$,
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.data == null) {
                return Container(child: Text("Fethcing..."));
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snap.data.length + 1,
                itemBuilder: (context, index) {
                  if (index == snap.data.length) {
                    return new GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/new-payment-method");
                        },
                        child: Column(children: <Widget>[
                          ListTile(
                            title: Text(
                              "Añadir nuevo método",
                              style: TextStyle(
                                  color: Color.fromRGBO(53, 175, 46, 1)),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Color.fromRGBO(184, 184, 184, 1),
                          )
                        ]));
                  }
                  return PaymentMethodListTile(
                    brand: snap.data[index]["card"]["brand"],
                    last4: snap.data[index]["card"]["last4"],
                    id: index,
                    cardHolder:
                        snap.data[index]["billing_details"]["name"] != null
                            ? snap.data[index]["billing_details"]["name"]
                            : "",
                  );
                },
              );
            }));
  }
}

class PaymentMethodListTile extends StatelessWidget {
  final String last4;
  final String brand;
  final int id;
  final String cardHolder;

  const PaymentMethodListTile(
      {Key key, this.last4, this.brand, this.id, this.cardHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: Text("•••• " + last4),
        leading: SvgPicture.asset(
          brand == "visa"
              ? 'assets/settings/methods/visa.svg'
              : 'assets/settings/methods/mastercard.svg',
          width: 48.0,
          height: 48.0,
        ),
      ),
      Divider(
        height: 1,
        color: Color.fromRGBO(184, 184, 184, 1),
      )
    ]);
  }
}
