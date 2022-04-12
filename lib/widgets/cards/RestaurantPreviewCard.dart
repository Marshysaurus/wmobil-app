import 'package:flutter/material.dart';
// External imports
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/models/Restaurant.dart';
import 'package:wmobil/streams/FiscalLog/FiscalLog.dart';
import 'package:wmobil/streams/Reports/Assists.dart';
import 'package:wmobil/streams/Reports/CancellationsAccounts.dart';
import 'package:wmobil/streams/Reports/CancellationsProducts.dart';
import 'package:wmobil/streams/Reports/DiscountsAccounts.dart';
import 'package:wmobil/streams/Reports/DiscountsProducts.dart';
import 'package:wmobil/streams/Reports/ProductionProducts.dart';
import 'package:wmobil/streams/Reports/SalesCuts.dart';
import 'package:wmobil/streams/Reports/SalesMovements.dart';
import 'package:wmobil/streams/Reports/SalesWaiter.dart';
import 'package:wmobil/streams/Reports/SalesWaiters.dart';
import 'package:wmobil/streams/Restaurant.dart';
import 'package:wmobil/streams/Restaurants.dart';
import 'package:wmobil/utils/ScreenArguments.dart';
import 'package:wmobil/widgets/buttons/DateLeadingButton.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
GetIt getIt = GetIt.instance;
final restaurant = getIt.get<Restaurant>();
final historicCuts = getIt.get<SalesCuts>();
final historicMovements = getIt.get<SalesMovements>();
final historicWaiters = getIt.get<SalesWaiters>();
final historicWaiter = getIt.get<SalesWaiter>();
final discountAccounts = getIt.get<DiscountsAccounts>();
final discountProducts = getIt.get<DiscountsProducts>();
final cancellationAccounts = getIt.get<CancellationsAccounts>();
final cancellationProducts = getIt.get<CancellationsProducts>();
final productionProducts = getIt.get<ProductionProducts>();
final assists = getIt.get<Assists>();
final fiscalLog = getIt.get<FiscalLog>();

class RestaurantPreviewCard extends StatefulWidget {
  final RestaurantModel restaurantModel;
  final String mode;
  final String info;
  final double commission;

  RestaurantPreviewCard(
      {Key key, this.restaurantModel, this.mode, this.info, this.commission})
      : super(key: key);

  @override
  _RestaurantPreviewCardState createState() => _RestaurantPreviewCardState();
}

class _RestaurantPreviewCardState extends State<RestaurantPreviewCard> {
  final restaurants = getIt.get<Restaurants>();

  @override
  Widget build(BuildContext context) {
    void onTapOnline(context, route) async {
      restaurants.fetchRestaurants();
      restaurant.setRestaurant(widget.restaurantModel.id);
      historicCuts.setRestaurant(widget.restaurantModel.id);
      historicMovements.setRestaurant(widget.restaurantModel.id);
      historicWaiters.setRestaurant(widget.restaurantModel.id);
      historicWaiter.setRestaurant(widget.restaurantModel.id);
      discountAccounts.setRestaurant(widget.restaurantModel.id);
      discountProducts.setRestaurant(widget.restaurantModel.id);
      cancellationAccounts.setRestaurant(widget.restaurantModel.id);
      cancellationProducts.setRestaurant(widget.restaurantModel.id);
      productionProducts.setRestaurant(widget.restaurantModel.id);
      assists.setRestaurant(widget.restaurantModel.id);
      fiscalLog.setRestaurant(widget.restaurantModel.id);
      Navigator.pushNamed(context, route,
              arguments:
                  ScreenArguments(restaurantName: widget.restaurantModel.title))
          .whenComplete(() => Future.delayed(Duration(milliseconds: 500), () {
                restaurant.removeRestaurant();
              }));
    }

    return GestureDetector(
      key: widget.key,
      onTapDown: (_) {
        if (searchDate.leadingSearchDate != LeadingDate.Live)
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: Text(
                "El uso de la funcionalidad online es exclusivo para la categoría en vivo",
                style: wBlackDialogContent500,
              ),
              contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
              actions: <Widget>[
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        else
          onTapOnline(context, "/restaurant");
      },
      child: Container(
        padding: widget.mode == "condensed"
            ? EdgeInsets.fromLTRB(16, 15, 8, 15)
            : EdgeInsets.fromLTRB(16, 10, 8, 10),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
        child: widget.mode == "condensed"
            ? Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.restaurantModel.title,
                      overflow: TextOverflow.ellipsis,
                      style: wBlackDefaultText700,
                    ),
                  ),
                  Text(
                    "\$",
                    style: wGreenDefaultText700,
                  ),
                  Text(
                    widget.info == "regalias"
                        ? currencyFormat.format(num.parse(
                            (widget.restaurantModel.getInfo("total") *
                                    widget.commission)
                                .toStringAsFixed(2)))
                        : currencyFormat.format(
                            widget.restaurantModel.getInfo(widget.info)),
                    style: wGreenDefaultText700,
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.restaurantModel.title,
                    overflow: TextOverflow.ellipsis,
                    style: wBlackDefaultText700,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisSize: MainAxisSize.min,
                        textBaseline: TextBaseline.ideographic,
                        children: <Widget>[
                          Text(
                            "\$",
                            style: wGreenDefaultText700,
                          ),
                          Text(
                            widget.info == "regalias"
                                ? currencyFormat.format(
                                    widget.restaurantModel.getInfo("total") *
                                        widget.commission)
                                : currencyFormat.format(widget.restaurantModel
                                    .getInfo(widget.info)),
                            style: wGreenDefaultText700,
                          ),
                        ],
                      ),
                      searchDate.leadingSearchDate.index == 0
                          ? Text(
                              "${widget.restaurantModel.tablesOpen} cuentas abiertas",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  letterSpacing: -.02,
                                  color: Color.fromRGBO(33, 33, 33, 1)))
                          : Container(),
                      // GestureDetector(
                      //   onTapDown: (TapDownDetails details) {
                      //     _showPopupMenu(details.globalPosition);
                      //   },
                      //   child: Icon(
                      //     Icons.more_vert,
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
