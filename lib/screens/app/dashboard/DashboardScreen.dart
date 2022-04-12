import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// External imports
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/Notifications/NotificationTypes.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/models/Restaurant.dart';
import 'package:wmobil/streams/Notifications/CancelledAccountsProvider.dart';
import 'package:wmobil/streams/Notifications/CancelledProductsProvider.dart';
import 'package:wmobil/streams/Notifications/DiscountsProvider.dart';
import 'package:wmobil/streams/Restaurant.dart';
import 'package:wmobil/streams/Restaurants.dart';
import 'package:wmobil/utils/Icons/w_custom_icons_icons.dart';
import 'package:wmobil/utils/Notifications.dart';
import 'package:wmobil/widgets/buttons/DateLeadingButton.dart';
import 'package:wmobil/widgets/cards/RestaurantPreviewCard.dart';

GetIt getIt = GetIt.instance;
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.ZZ");

enum DropdownText {
  total,
  efectivo,
  tarjeta,
  otros,
  efectivoEnCaja,
  totalFacturado,
  totalCostos,
  utilidad,
  regalias,
}

extension DropdownTextExtension on DropdownText {
  String get text {
    switch (this) {
      case DropdownText.total:
        return 'Total';
        break;
      case DropdownText.efectivo:
        return 'Efectivo';
        break;
      case DropdownText.tarjeta:
        return 'Tarjeta';
        break;
      case DropdownText.otros:
        return 'Otros';
        break;
      case DropdownText.efectivoEnCaja:
        return 'Efectivo en caja';
        break;
      case DropdownText.totalFacturado:
        return 'Total facturado';
        break;
      case DropdownText.totalCostos:
        return 'Total costos';
        break;
      case DropdownText.utilidad:
        return 'Utilidad';
        break;
      case DropdownText.regalias:
        return 'Regalías';
        break;
      default:
        return null;
    }
  }
}

const dropdownFilterForGeneralData = {
  DropdownText.total: 'total',
  DropdownText.efectivo: 'efectivo',
  DropdownText.tarjeta: 'tarjeta',
  DropdownText.otros: 'otros',
  DropdownText.efectivoEnCaja: 'efectivoEnCaja',
  DropdownText.totalFacturado: 'totalFacturado',
  DropdownText.totalCostos: 'totalCostos',
  DropdownText.utilidad: 'utilidad',
  DropdownText.regalias: 'regalias',
};

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  final restaurants = getIt.get<Restaurants>();
  final restaurant = getIt.get<Restaurant>();
  final cancelledProducts = getIt.get<CancelledProductsProvider>();
  final cancelledAccounts = getIt.get<CancelledAccountsProvider>();
  final discounts = getIt.get<DiscountsProvider>();
  final allNotifications = getIt.get<AllNotifications>();
  final productsNotifications = getIt.get<CancelledProductNotification>();
  final accountsNotifications = getIt.get<CancelledAccountNotification>();
  final discountsNotifications = getIt.get<DiscountNotification>();

  List<RestaurantModel> restaurantList = [];

  String _mode = "condensed";
  DropdownText _info = DropdownText.total;
  DropdownText _previousInfo = DropdownText.total;

  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(
  //     () {
  //       if (newIndex > oldIndex) {
  //         newIndex -= 1;
  //       }
  //       final RestaurantModel item = restaurantList.removeAt(oldIndex);
  //       restaurantList.insert(newIndex, item);
  //     },
  //   );
  // }

  void initializing() async {
    androidInitializationSettings =
        AndroidInitializationSettings('drawable/app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications(
      {dynamic restaurant, NotificationType notificationType}) async {
    await notification(
      restaurant: restaurant,
      notificationType: notificationType,
    );
  }

  Future<void> notification(
      {dynamic restaurant, NotificationType notificationType}) async {
    String notificationTitle;
    String notificationMessage;

    switch (notificationType) {
      case NotificationType.producto:
        notificationTitle = 'Productos Cancelados';
        notificationMessage =
            'Un producto fue cancelado en ${restaurant["text"]}';
        break;
      case NotificationType.cuenta:
        notificationTitle = 'Cuentas Canceladas';
        notificationMessage =
            'Una cuenta fue cancelada en ${restaurant["text"]}';
        break;
      case NotificationType.descuento:
        notificationTitle = 'Descuentos';
        notificationMessage =
            'Un descuento fue realizado en ${restaurant["text"]}';
        break;
    }
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('wmobil', 'WMobil', 'WMobil',
            priority: Priority.high,
            importance: Importance.max,
            ticker: 'test',
            styleInformation: InboxStyleInformation([]));

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, notificationTitle, notificationMessage, notificationDetails,
        payload: '${restaurant["id"]}');
  }

  Future onSelectNotification(String payLoad) {
    restaurants.fetchRestaurants();
    restaurant.setRestaurant(int.parse(payLoad));
    Navigator.pushNamed(context, "/restaurant", arguments: 6)
        .whenComplete(() => Future.delayed(Duration(milliseconds: 500), () {
              restaurant.removeRestaurant();
            }));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true, onPressed: () {}, child: Text("Okay")),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    initializing();

    StreamSubscription productsNotificationsStream =
        cancelledProducts.notificationsStream.listen((event) {
      if (event.length > 0)
        _showNotifications(
          restaurant: event.last["restaurante"],
          notificationType: NotificationType.producto,
        );
    }, onError: (error) {}, onDone: () {});

    StreamSubscription accountsNotificationsStream =
        cancelledAccounts.notificationsStream.listen((event) {
      if (event.length > 0)
        _showNotifications(
          restaurant: event.last["restaurante"],
          notificationType: NotificationType.cuenta,
        );
    }, onError: (error) {}, onDone: () {});

    StreamSubscription discountsNotificationsStream =
        discounts.notificationsStream.listen((event) {
      if (event.length > 0)
        _showNotifications(
          restaurant: event.last["restaurante"],
          notificationType: NotificationType.descuento,
        );
    }, onError: (error) {}, onDone: () {});

    productsNotifications.stream$.listen((areNotificationsEnabled) {
      if (areNotificationsEnabled ?? true) {
        productsNotificationsStream.resume();
      } else {
        productsNotificationsStream.pause();
      }
    });
    accountsNotifications.stream$.listen((areNotificationsEnabled) {
      if (areNotificationsEnabled ?? true) {
        accountsNotificationsStream.resume();
      } else {
        accountsNotificationsStream.pause();
      }
    });
    discountsNotifications.stream$.listen((areNotificationsEnabled) {
      if (areNotificationsEnabled ?? true) {
        discountsNotificationsStream.resume();
      } else {
        discountsNotificationsStream.pause();
      }
    });

    // allNotifications.stream$.listen((isActiveEvent) {
    //   if (isActiveEvent) {
    //
    //     productsNotificationsStream.resume();
    //     accountsNotificationsStream.resume();
    //     discountsNotificationsStream.resume();
    //   } else {
    //     productsNotificationsStream.pause();
    //     accountsNotificationsStream.pause();
    //     discountsNotificationsStream.pause();
    //   }
    // });

    restaurants.fetchRestaurants();
    cancelledProducts.fetchCancelledProducts();
    cancelledAccounts.fetchCancelledAccounts();
    discounts.fetchDiscounts();

    Timer.periodic(Duration(seconds: 120), (_) {
      restaurants.fetchRestaurants();
      if (restaurant.current != null) restaurant.fetchRestaurant();
    });
    Timer.periodic(Duration(seconds: 60), (_) {
      cancelledProducts.fetchCancelledProducts();
      cancelledAccounts.fetchCancelledAccounts();
      discounts.fetchDiscounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: restaurants.stream$,
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.waiting ||
            snap.data == null)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16),
                child: InkWell(
                  child: Icon(
                    WCustomIcons.menu,
                    color: Colors.white,
                    size: 18,
                  ),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFF0F3F7),
                  ),
                ),
              )
            ],
          );

        double total = 0;
        restaurantList.clear();

        for (var restaurant in snap.data["restaurants"]) {
          RestaurantModel singleRestaurant =
              RestaurantModel.fromJSON(restaurant);

          if (restaurantList
              .every((element) => element.id != singleRestaurant.id))
            restaurantList.add(singleRestaurant);
          if (_info == DropdownText.regalias) {
            total += double.parse(
                    "${restaurant[searchDate.leadingSearchDate.value]['total']}") *
                singleRestaurant.commission;
          } else {
            total += double.parse(
                "${restaurant[searchDate.leadingSearchDate.value][dropdownFilterForGeneralData[_info]] ?? 0}");
          }
        }

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          width: 28,
                          child: Icon(
                            WCustomIcons.menu,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      Spacer(),
                      // Icon(
                      //   WCustomIcons.sort,
                      //   color: Colors.white,
                      //   size: 14,
                      // ),
                      // SizedBox(width: 6),
                      InkWell(
                        child: Container(
                          width: 28,
                          child: Icon(
                            _mode == "condensed"
                                ? WCustomIcons.expanded
                                : WCustomIcons.condensed,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        onTap: () {
                          if (_mode == "") {
                            setState(() {
                              _mode = "condensed";
                            });
                          } else {
                            setState(() {
                              _mode = "";
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    "Restaurantes",
                    style: wWhiteTitle700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                generalRestaurantsCardInfo(data: snap.data, total: total),
                SizedBox(height: 8),
                dateRowForDataQuery(),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: restaurantList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == restaurantList.length)
                        return SizedBox(height: 45);

                      return RestaurantPreviewCard(
                        key: Key('${restaurantList[index].id}'),
                        restaurantModel: restaurantList[index],
                        mode: _mode,
                        info: dropdownFilterForGeneralData[_info],
                        commission: restaurantList[index].commission,
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 45,
                width: 158,
                margin: EdgeInsets.only(
                  right: 16,
                  bottom: 24,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    primary: Color(0xFF5BAC43),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _info != DropdownText.regalias
                            ? "Ver regalías"
                            : "Listo",
                        style: wWhiteButtonText700,
                      ),
                      _info != DropdownText.regalias
                          ? SizedBox(width: 5)
                          : Container(height: 0),
                      _info != DropdownText.regalias
                          ? Icon(
                              WCustomIcons.piggy,
                              color: Colors.white,
                              size: 14,
                            )
                          : Container(height: 0),
                    ],
                  ),
                  onPressed: () {
                    if (_info != DropdownText.regalias)
                      setState(() {
                        _info = DropdownText.regalias;
                      });
                    else
                      setState(() {
                        _info = _previousInfo;
                      });
                  },
                ),
              ),
            )
          ],
        );
      },
    );
    // return Scaffold(
    // appBar: AppBar(
    //   elevation: 0.0,
    //   backgroundColor: Colors.white,
    //   centerTitle: true,
    //   automaticallyImplyLeading: false,
    //   title: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       SizedBox(width: 16),
    //       Container(
    //         width: 60,
    //         child: InkWell(
    //           focusColor: Colors.transparent,
    //           highlightColor: Colors.transparent,
    //           splashColor: Colors.transparent,
    //           onTap: () {
    //             if (_info == "efectivoEnCaja" &&
    //                 searchDate.leadingSearchDate.index == 0)
    //               setState(() {
    //                 _info = "total";
    //               });
    //             if (searchDate.leadingSearchDate.index == 3)
    //               setState(() {
    //                 searchDate.leadingSearchDate = LeadingDate.values[0];
    //               });
    //             else
    //               setState(() {
    //                 searchDate.leadingSearchDate = LeadingDate
    //                     .values[searchDate.leadingSearchDate.index + 1];
    //               });
    //             Scaffold.of(context).hideCurrentSnackBar();
    //             Scaffold.of(context).showSnackBar(SnackBar(
    //               behavior: SnackBarBehavior.fixed,
    //               content: Text(
    //                   'Búsqueda desde ${searchDate.leadingSearchDate.message}'),
    //               action: SnackBarAction(
    //                 label: 'Ocultar',
    //                 onPressed: () {
    //                   Scaffold.of(context).hideCurrentSnackBar();
    //                 },
    //               ),
    //             ));
    //           },
    //           child: searchDate.leadingSearchDate.button,
    //         ),
    //       ),
    //       Expanded(
    //         child: Center(
    //           child: Text("Restaurantes",
    //               style: TextStyle(
    //                   fontWeight: FontWeight.w700,
    //                   fontSize: 18,
    //                   letterSpacing: -.02,
    //                   color: Color.fromRGBO(33, 33, 33, 1))),
    //         ),
    //       )
    //     ],
    //   ),
    //   titleSpacing: 0.0,
    //   actions: [
    //     InkWell(
    //       child: Container(
    //         margin: EdgeInsets.symmetric(
    //           horizontal: 20,
    //         ),
    //         child: Icon(
    //           _mode == "condensed" ? Icons.unfold_more : Icons.unfold_less,
    //           color: Colors.black,
    //         ),
    //       ),
    //       onTap: () {
    //         if (_mode == "") {
    //           setState(() {
    //             _mode = "condensed";
    //           });
    //         } else {
    //           setState(() {
    //             _mode = "";
    //           });
    //         }
    //       },
    //     ),
    //   ],
    // ),
    // );
  }

  Widget generalRestaurantsCardInfo({dynamic data, double total}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(3, 2),
          ),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${currencyFormat.format(total)}',
                style: wGreenTitle700,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Text(
              //       "Última actualización",
              //       style: wGreyHint500,
              //     ),
              //     Text(
              //       (data["overview"]["last_fetched"] as String)
              //           .substring(11, 19),
              //       style: wBlackLastUpdate400,
              //     ),
              //   ],
              // )
            ],
          ),
          SizedBox(height: 5),
          _info == DropdownText.regalias
              ? Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    _info.text,
                    style: wBlackOptionSelection500,
                  ),
                )
              : DropdownButton(
                  value: _info,
                  isDense: true,
                  underline: Container(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  iconDisabledColor: Colors.black,
                  iconEnabledColor: Colors.black,
                  items: <DropdownText>[
                    DropdownText.total,
                    DropdownText.efectivo,
                    DropdownText.tarjeta,
                    DropdownText.otros,
                    DropdownText.efectivoEnCaja,
                    DropdownText.totalFacturado,
                    DropdownText.totalCostos,
                    DropdownText.utilidad,
                  ].map<DropdownMenuItem<DropdownText>>((DropdownText value) {
                    TextStyle dropdownStyle;

                    if (value == DropdownText.efectivoEnCaja &&
                        searchDate.leadingSearchDate != LeadingDate.Live) {
                      dropdownStyle = wGreyOptionSelection500;
                    } else {
                      dropdownStyle = wBlackOptionSelection500;
                    }

                    return DropdownMenuItem<DropdownText>(
                      value: value,
                      child: Text(
                        value.text,
                        style: dropdownStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (DropdownText newValue) {
                    if (searchDate.leadingSearchDate == LeadingDate.Live ||
                        newValue != DropdownText.efectivoEnCaja) {
                      setState(() {
                        _info = newValue;
                        _previousInfo = newValue;
                      });
                    }
                  },
                ),
        ],
      ),
    );
  }

  Widget dateRowForDataQuery() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Row(
        children: [
          dateContainerForDataQuery(
            date: LeadingDate.Live,
            isSelected: searchDate.leadingSearchDate == LeadingDate.Live,
          ),
          SizedBox(width: 8),
          dateContainerForDataQuery(
            date: LeadingDate.Week,
            isSelected: searchDate.leadingSearchDate == LeadingDate.Week,
          ),
          SizedBox(width: 8),
          dateContainerForDataQuery(
            date: LeadingDate.Month,
            isSelected: searchDate.leadingSearchDate == LeadingDate.Month,
          ),
          SizedBox(width: 8),
          dateContainerForDataQuery(
            date: LeadingDate.Year,
            isSelected: searchDate.leadingSearchDate == LeadingDate.Year,
          ),
        ],
      ),
    );
  }

  Widget dateContainerForDataQuery({LeadingDate date, bool isSelected}) {
    return Expanded(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.white : Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: isSelected ? Colors.white : Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: date.button,
          // Center(
          //   child: Text(cardText,
          //       style: isSelected
          //           ? wBlackOptionSelection500
          //           : wGreyOptionSelection500),
          // ),
        ),
        onTap: () {
          setState(() {
            if (_info == DropdownText.efectivoEnCaja &&
                date != LeadingDate.Live) _info = DropdownText.total;
            searchDate.leadingSearchDate = date;
          });
        },
      ),
    );
  }
}
