import 'package:flutter/material.dart';
// Internal imports
import 'package:wmobil/screens/app/dashboard/DashboardScreen.dart';
import 'package:wmobil/screens/app/dashboard/DetailedDashboardScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/cancellations_screens/CancellationsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/discounts_screens/DiscountsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/fiscal_log_screens/FiscalLogScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/sales_screens/WaitersDeliveryScreen.dart';
import 'package:wmobil/screens/app/dashboard/restaurant_screens/DetailedMovementsScreen.dart';
import 'package:wmobil/screens/app/dashboard/restaurant_screens/DetailedRestaurantScreen.dart';
import 'package:wmobil/screens/app/dashboard/DetailedTableScreen.dart';
import 'package:wmobil/screens/app/dashboard/restaurant_screens/RestaurantScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/sales_screens/SalesScreen.dart';
import 'package:wmobil/screens/app/settings/HelpScreen.dart';
import 'package:wmobil/screens/app/settings/MyAccountScreen.dart';
import 'package:wmobil/screens/app/settings/NotificationsScreen.dart';
import 'package:wmobil/utils/ScreenArguments.dart';

class DashBoardRoot extends StatelessWidget {
  const DashBoardRoot({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        final ScreenArguments args = settings.arguments;

        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return DashboardScreen();
                break;
              case '/detail':
                return DetailedDashboardScreen();
                break;
              case '/reports/sales':
                return SalesScreen();
                break;
              case '/reports/sales/waiter':
                return WaitersDeliveryScreen();
                break;
              case '/reports/discounts':
                return DiscountsScreen();
                break;
              case '/reports/cancellations':
                return CancellationsScreen();
                break;
              case '/reports/fiscal-log':
                return FiscalLogScreen();
                break;
              case '/restaurant':
                return RestaurantScreen(
                    restaurantName: args.restaurantName, showing: args.showing);
                break;
              case '/restaurant/detail':
                return DetailedRestaurantScreen();
                break;
              case '/restaurant/detail/movements':
                return DetailedMovementsScreen(
                  restaurantName: args.restaurantName,
                  movements: args.movements,
                );
                break;
              case '/table/detail':
                return DetailedTableScreen(
                  restaurantName: args.restaurantName,
                  lastFetched: args.lastFetched,
                  folio: args.folio,
                  isOpen: args.isOpen,
                );
                break;
              case '/my-account':
                return MyAccountScreen();
                break;
              case "/notifications":
                return NotificationSettingsScreen();
                break;
              case "/help":
                return HelpScreen();
                break;
              default:
                return Scaffold(
                  appBar: AppBar(
                    leading: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                );
                break;
            }
          },
        );
      },
    );
  }
}
