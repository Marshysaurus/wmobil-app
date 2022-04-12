import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/constants/Categories/ReportCategories.dart';
import 'package:wmobil/constants/Categories/TableCategories.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/models/Restaurant.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/assists_screens/AssistsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/cancellations_screens/CancellationsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/discounts_screens/DiscountsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/fiscal_log_screens/FiscalLogScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/production_screens/ProductionScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/sales_screens/SalesScreen.dart';
import 'package:wmobil/streams/TableStream.dart';
import 'package:wmobil/utils/Icons/w_custom_icons_icons.dart';
import 'package:wmobil/utils/ScreenArguments.dart';
import 'package:wmobil/widgets/cards/CancelledProductCard.dart';
import 'package:wmobil/widgets/cards/DiscountsAndCancellationsCard.dart';
import 'package:wmobil/widgets/cards/MovementsCard.dart';
import 'package:wmobil/widgets/cards/Online/Home/GeneralDataCard.dart' as Home;
import 'package:wmobil/widgets/cards/Online/Table/GeneralDataCard.dart'
    as Table;
import 'package:wmobil/widgets/cards/Online/Reports/GeneralDataCard.dart'
    as Reports;
import 'package:wmobil/widgets/cards/Online/Table/Products/RegularProductCard.dart';
import 'package:wmobil/widgets/cards/Online/Table/Products/TopProductCard.dart';
import 'package:wmobil/widgets/cards/PaymentMethodsCard.dart';
import 'package:wmobil/widgets/cards/ProductsCard.dart';
import 'package:wmobil/widgets/cards/RestaurantPreviewCard.dart' as Preview;
import 'package:wmobil/widgets/cards/RestaurantStatsCard.dart';
import 'package:wmobil/widgets/cards/TableCard.dart';
import 'package:wmobil/widgets/cards/TurnsCard.dart';
import 'package:wmobil/widgets/cards/WaiterCard.dart';

GetIt getIt = GetIt.instance;

class RestaurantScreen extends StatefulWidget {
  final tableStream = getIt.get<TableStream>();
  final String restaurantName;
  final int showing;

  RestaurantScreen({this.restaurantName, this.showing});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Timer _timer;

  int _stackIndex = 0;

  Map<int, int> foodMap = Map();
  Map<int, int> drinkMap = Map();

  TableCategory selectedTableCategory = TableCategory.cuentasAbiertas;
  ReportCategory selectedReportCategory = ReportCategory.ventas;

  void rankMovements(List<dynamic> itemsList, Map rankMap) {
    rankMap.clear();
    List<int> ranking = [];
    int rank = 1;

    itemsList.forEach((element) {
      ranking.add(element['ranking']);
    });

    ranking.sort((int b, int a) {
      return b.compareTo(a);
    });

    for (int i = 0; i < ranking.length; i++) {
      int element = ranking[i];

      if (!rankMap.containsKey(element)) {
        rankMap[element] = rank;
        rank++;
      }
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 120000), (timer) {
      Preview.restaurant.fetchRestaurant();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 14),
              Text(
                "Todos los restaurantes",
                style: wWhiteSubtitle500,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 16),
          child: Text(
            widget.restaurantName,
            style: wWhiteTitle700,
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              IndexedStack(
                index: _stackIndex,
                children: [
                  homeRestaurantData(),
                  tableRestaurantData(),
                  reportsRestaurantData(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(48)),
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  margin: EdgeInsets.only(bottom: 24),
                  width: 184,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: Icon(
                            Icons.home,
                            color: _stackIndex == 0
                                ? Colors.white
                                : Color(0xFF838383),
                            size: 24,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _stackIndex = 0;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Icon(
                            WCustomIcons.table,
                            color: _stackIndex == 1
                                ? Colors.white
                                : Color(0xFF838383),
                            size: 24,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _stackIndex = 1;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Icon(
                            WCustomIcons.receipt,
                            color: _stackIndex == 2
                                ? Colors.white
                                : Color(0xFF838383),
                            size: 24,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _stackIndex = 2;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget homeRestaurantData() {
    return StreamBuilder<Object>(
      stream: Preview.restaurant.stream$,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null || snapshot.data["loading"]) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(53, 175, 46, 1)),
            ),
          );
        }

        RestaurantModel restaurantModel =
            RestaurantModel.fromJSON(snapshot.data);

        rankMovements(restaurantModel.food, foodMap);
        rankMovements(restaurantModel.drinks, drinkMap);

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Home.GeneralDataCard(
                restaurantModel: restaurantModel,
              ),
              SizedBox(height: 16),
              restaurantModel.paymentMethods.length != 0
                  ? PaymentMethodsCard(
                      paymentMethod: restaurantModel.paymentMethods,
                    )
                  : Container(),
              restaurantModel.paymentMethods.length != 0
                  ? SizedBox(height: 8)
                  : Container(),
              ProductsCard(
                drinkRevenue: restaurantModel.drinkRevenue,
                foodRevenue: restaurantModel.foodRevenue,
              ),
              SizedBox(height: 8),
              MovementsCard(
                restaurantName: widget.restaurantName,
                movements: restaurantModel.movements,
              ),
              SizedBox(height: 8),
              TurnsCard(
                turns: restaurantModel.turns,
              ),
              SizedBox(height: 8),
              DiscountsAndCancellationsCard(
                discounts: restaurantModel.discounts,
                productCancellations: restaurantModel.cancellations,
                tableCancellations: restaurantModel.cancelledAccounts,
                discountsPerProduct: restaurantModel.discountsPerProduct,
                discountsPerAccount: restaurantModel.discountsPerAccount,
                cancellationsPerAccount: restaurantModel.cancellationsPerAccount,
                cancellationsPerProduct: restaurantModel.cancellationsPerProduct,
              ),
              SizedBox(height: 8),
              RestaurantStatsCard(
                lastMonth: restaurantModel.lastMonthTotal,
                lastWeek: restaurantModel.lastWeekTotal,
                lastYear: restaurantModel.lastYearTotal,
                prediction: restaurantModel.prediction,
              ),
              SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }

  Widget tableRestaurantData() {
    return StreamBuilder<Object>(
      stream: Preview.restaurant.stream$,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null || snapshot.data["loading"]) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(53, 175, 46, 1)),
            ),
          );
        }

        RestaurantModel restaurantModel =
            RestaurantModel.fromJSON(snapshot.data);

        rankMovements(restaurantModel.food, foodMap);
        rankMovements(restaurantModel.drinks, drinkMap);

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Table.GeneralDataCard(
                  restaurantModel: restaurantModel,
                  currentTableCategory: selectedTableCategory,
                  callback: (val) =>
                      setState(() => selectedTableCategory = val)),
              SizedBox(height: 4),
              tableCategoryList(
                selectedTableCategory: selectedTableCategory,
                restaurantModel: restaurantModel,
                restaurantName: widget.restaurantName,
              ),
              SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }

  // Categories for the table section
  Widget tableCategoryList({
    TableCategory selectedTableCategory,
    RestaurantModel restaurantModel,
    String restaurantName,
  }) {
    switch (selectedTableCategory) {
      case TableCategory.cuentasAbiertas:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
                children: restaurantModel.openTables.map<Widget>((table) {
              return InkWell(
                  onTap: () {
                    widget.tableStream
                        .setTable(table["folio"], restaurantModel.id);
                    Navigator.pushNamed(
                      context,
                      "/table/detail",
                      arguments: ScreenArguments(
                        restaurantName: restaurantName,
                        lastFetched: restaurantModel.lastFetched,
                        folio: table["folio"],
                        isOpen: true,
                      ),
                    );
                  },
                  child: TableCard(
                    isOpen: true,
                    table: table,
                  ));
            }).toList())
          ],
        );
        break;
      case TableCategory.cuentasCerradas:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
                children: restaurantModel.closedTables.map<Widget>((table) {
              return InkWell(
                  onTap: () {
                    widget.tableStream
                        .setTable(table["folio"], restaurantModel.id);
                    Navigator.pushNamed(
                      context,
                      "/table/detail",
                      arguments: ScreenArguments(
                        restaurantName: restaurantName,
                        lastFetched: restaurantModel.lastFetched,
                        folio: table["folio"],
                        isOpen: false,
                      ),
                    );
                  },
                  child: TableCard(
                    isOpen: false,
                    table: table,
                  ));
            }).toList())
          ],
        );
        break;
      case TableCategory.topMeseros:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
                children: restaurantModel.waiters.map<Widget>((waiter) {
              return WaiterCard(
                waiter: waiter,
              );
            }).toList())
          ],
        );
        break;
      case TableCategory.topProductos:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
                children: restaurantModel.products.map<Widget>((product) {
              if (int.parse("${product["ranking"]}") <= 3)
                return TopProductCard(product: product);
              else
                return Container();
            }).toList()),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: restaurantModel.products.map<Widget>((product) {
                      if (int.parse("${product["ranking"]}") > 3 &&
                          int.parse("${product["ranking"]}") % 2 == 0)
                        return RegularProductCard(product: product);
                      else
                        return Container();
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: restaurantModel.products.map<Widget>((product) {
                      if (int.parse("${product["ranking"]}") > 3 &&
                          int.parse("${product["ranking"]}") % 2 == 1)
                        return RegularProductCard(product: product);
                      else
                        return Container();
                    }).toList(),
                  ),
                ),
              ],
            )
          ],
        );
        break;
      case TableCategory.topAlimentos:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
                children: restaurantModel.food.map<Widget>((product) {
              return RegularProductCard(product: product);
            }).toList())
          ],
        );
        break;
      case TableCategory.topBebidas:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
                children: restaurantModel.drinks.map<Widget>((product) {
              return RegularProductCard(product: product);
            }).toList())
          ],
        );
        break;
      case TableCategory.productosCancelados:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
              children:
                  restaurantModel.cancelledProducts.map<Widget>((product) {
                return CancelledProductCard(product: product);
              }).toList(),
            )
          ],
        );
        break;
      case TableCategory.cuentasCanceladas:
        return Column(
          children: [
            SizedBox(height: 12),
            Column(
                children: restaurantModel.cancelledTables.map<Widget>((table) {
              return InkWell(
                  onTap: () {
                    widget.tableStream
                        .setTable(table["folio"], restaurantModel.id);
                    Navigator.pushNamed(context, "/table/detail",
                        arguments: ScreenArguments(
                          restaurantName: restaurantName,
                          lastFetched: restaurantModel.lastFetched,
                          folio: table["folio"],
                          isOpen: false,
                        ));
                  },
                  child: TableCard(
                    isOpen: true,
                    table: table,
                  ));
            }).toList())
          ],
        );
        break;
      default:
        return Container();
    }
  }

  Widget reportsRestaurantData() {
    return StreamBuilder<Object>(
      stream: Preview.restaurant.stream$,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null || snapshot.data["loading"]) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(53, 175, 46, 1)),
            ),
          );
        }

        RestaurantModel restaurantModel =
            RestaurantModel.fromJSON(snapshot.data);

        rankMovements(restaurantModel.food, foodMap);
        rankMovements(restaurantModel.drinks, drinkMap);

        return StreamBuilder(
            stream: Preview.fiscalLog.stream$,
            builder: (context, fiscalSnapshot) {
              if (fiscalSnapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(53, 175, 46, 1)),
                  ),
                );

              // !fiscalSnapshot?.data["canGetBitacoraFiscal"]

              return Column(
                children: <Widget>[
                  Reports.GeneralDataCard(
                      restaurantModel: restaurantModel,
                      isFiscalLogVisible:
                          fiscalSnapshot?.data["canGetBitacoraFiscal"],
                      currentReportCategory: selectedReportCategory,
                      callback: (val) =>
                          setState(() => selectedReportCategory = val)),
                  SizedBox(height: 8),
                  Expanded(
                    child: reportsCategoryList(
                      selectedReportCategory: selectedReportCategory,
                      restaurantName: widget.restaurantName,
                    ),
                  ),
                ],
              );
            });
      },
    );
  }

  Widget reportsCategoryList({
    ReportCategory selectedReportCategory,
    String restaurantName,
  }) {
    switch (selectedReportCategory) {
      case ReportCategory.ventas:
        return SalesScreen(
          restaurantName: widget.restaurantName,
        );
        break;
      case ReportCategory.descuentos:
        return DiscountsScreen(
          restaurantName: widget.restaurantName,
        );
        break;
      case ReportCategory.cancelaciones:
        return CancellationsScreen(
          restaurantName: widget.restaurantName,
        );
        break;
      case ReportCategory.produccion:
        return ProductionScreen(
          restaurantName: widget.restaurantName,
        );
        break;
      case ReportCategory.asistencias:
        return AssistsScreen(
          restaurantName: widget.restaurantName,
        );
        break;
      case ReportCategory.bitacoraFiscal:
        return FiscalLogScreen(
          restaurantName: widget.restaurantName,
        );
        break;
      default:
        return Container();
    }
  }
}
