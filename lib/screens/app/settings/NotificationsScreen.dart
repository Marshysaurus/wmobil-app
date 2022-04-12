import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/Notifications.dart';

GetIt getIt = GetIt.instance;

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key key}) : super(key: key);

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // final allNotifications = getIt.get<AllNotifications>();
    final cancelledProductsNotifications =
        getIt.get<CancelledProductNotification>();
    final cancelledAccountsNotifications =
        getIt.get<CancelledAccountNotification>();
    final discountsNotifications = getIt.get<DiscountNotification>();

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
          title: Text("Notificaciones", style: wTextStyleAppBar),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    // StreamBuilder(
                    //     stream: allNotifications.stream$,
                    //     builder: (BuildContext context, AsyncSnapshot snap) {
                    //       if (snap.data == null) return Container();
                    //
                    //       return ListTile(
                    //         trailing: Switch(
                    //           value: snap.data,
                    //           onChanged: (value) async {
                    //             await allNotifications
                    //                 .toggleForNotifications(value);
                    //             setState(() {});
                    //           },
                    //           activeTrackColor: Color.fromRGBO(53, 175, 46, 1),
                    //           activeColor: Color.fromRGBO(53, 175, 46, 1),
                    //         ),
                    //         title: Row(
                    //           children: <Widget>[
                    //             Text("Todas",
                    //                 style: TextStyle(
                    //                   color: Color.fromRGBO(74, 74, 74, 1),
                    //                 ))
                    //           ],
                    //         ),
                    //       );
                    //     }),
                    StreamBuilder(
                        stream: cancelledProductsNotifications.stream$,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (snap.data == null) return Container();

                          return ListTile(
                            trailing: Switch(
                              value: snap.data,
                              onChanged: (value) async {
                                await cancelledProductsNotifications
                                    .toggleForNotifications(value);
                                setState(() {});
                              },
                              activeTrackColor: Color.fromRGBO(53, 175, 46, 1),
                              activeColor: Color.fromRGBO(53, 175, 46, 1),
                            ),
                            title: Row(
                              children: <Widget>[
                                Text("Productos Cancelados",
                                    style: TextStyle(
                                      color: Color.fromRGBO(74, 74, 74, 1),
                                    ))
                              ],
                            ),
                          );
                        }),
                    StreamBuilder(
                        stream: cancelledAccountsNotifications.stream$,
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (snap.data == null) return Container();

                          return ListTile(
                            trailing: Switch(
                              value: snap.data,
                              onChanged: (value) async {
                                await cancelledAccountsNotifications
                                    .toggleForNotifications(value);
                                setState(() {});
                              },
                              activeTrackColor: Color.fromRGBO(53, 175, 46, 1),
                              activeColor: Color.fromRGBO(53, 175, 46, 1),
                            ),
                            title: Row(
                              children: <Widget>[
                                Text("Cuentas Canceladas",
                                    style: TextStyle(
                                      color: Color.fromRGBO(74, 74, 74, 1),
                                    ))
                              ],
                            ),
                          );
                        }),
                    StreamBuilder(
                      stream: discountsNotifications.stream$,
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.data == null) return Container();

                        return ListTile(
                          trailing: Switch(
                            value: snap.data,
                            onChanged: (value) async {
                              await discountsNotifications
                                  .toggleForNotifications(value);
                              setState(() {});
                            },
                            activeTrackColor: Color.fromRGBO(53, 175, 46, 1),
                            activeColor: Color.fromRGBO(53, 175, 46, 1),
                          ),
                          title: Row(
                            children: <Widget>[
                              Text("Descuentos",
                                  style: TextStyle(
                                    color: Color.fromRGBO(74, 74, 74, 1),
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
