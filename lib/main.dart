import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// External imports
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';
// Internal imports
import 'package:wmobil/Wrapper.dart';
import 'package:wmobil/constants/colors.dart';
import 'package:wmobil/constants/paddings.dart';
import 'package:wmobil/constants/textStyles.dart';
// import 'package:wmobil/models/Destination.dart';
import 'package:wmobil/screens/app/dashboard/DashboardRoot.dart';
import 'package:wmobil/screens/app/settings/NotificationsScreen.dart';
import 'package:wmobil/streams/FiscalLog/FiscalLog.dart';
import 'package:wmobil/streams/Notifications/CancelledAccountsProvider.dart';
import 'package:wmobil/streams/Notifications/CancelledProductsProvider.dart';
import 'package:wmobil/streams/Notifications/DiscountsProvider.dart';
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
import 'package:wmobil/streams/PaymentMethods.dart';
import 'package:wmobil/streams/Restaurant.dart';
import 'package:wmobil/streams/Restaurants.dart';
import 'package:wmobil/streams/TableStream.dart';
import 'package:wmobil/streams/User.dart';
import 'package:wmobil/utils/Auth.dart';
import 'package:wmobil/utils/CustomPainter/DashboardPainter.dart';
import 'package:wmobil/utils/Notifications.dart';

GetIt getIt = GetIt.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  final user = getIt.get<User>();
  final restaurants = getIt.get<Restaurants>();

  final Uri _emailLaunchUri = Uri(
      scheme: "mailto",
      path: "wmobilapp@gmail.com",
      queryParameters: {'subject': 'Servicio al cliente WMobil'});

  @override
  Widget build(BuildContext context) {
    Widget shimmerTextWidget = SkeletonAnimation(
      shimmerColor: wColorsBrand,
      borderRadius: BorderRadius.circular(5),
      shimmerDuration: 1000,
      child: Container(
        decoration: BoxDecoration(
          color: wColorsBrand.withOpacity(0.6),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: wColorsBrand.withOpacity(0.6),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      drawer: SafeArea(
        child: Container(
          width: 290,
          child: Drawer(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder(
                    stream: user.stream$,
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: wColorsBrand,
                            padding: EdgeInsets.only(
                              top: 28,
                              bottom: 24,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  height: 24,
                                  margin: EdgeInsets.only(
                                    left: 16,
                                    bottom: 4,
                                  ),
                                  child: snap.data != null
                                      ? Text(
                                          "${snap.data["name"]} ${snap.data["lastName"]}",
                                          style: wWhiteButtonText700,
                                        )
                                      : shimmerTextWidget,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  height: 24,
                                  margin: EdgeInsets.only(left: 16),
                                  child: snap.data != null
                                      ? Text(
                                          snap.data["email"],
                                          style: wWhiteButtonText700,
                                        )
                                      : shimmerTextWidget,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              'Menú',
                              style: wGreenTitle700,
                            ),
                          ),
                          SizedBox(height: 6),
                          // drawerCategory(
                          //   Icons.person,
                          //   'Mi cuenta',
                          //   () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => MyAccountScreen(),
                          //     ),
                          //   ),
                          // ),
                          drawerCategory(
                            Icons.notifications,
                            'Notificaciones',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotificationSettingsScreen(),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              "Ayuda",
                              style: wGreenTitle700,
                            ),
                          ),
                          SizedBox(height: 6),
                          // drawerCategory(
                          //   Icons.help,
                          //   'Ayuda',
                          //   () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => HelpScreen()),
                          //   ),
                          // ),
                          drawerCategory(
                              Icons.mail,
                              "wmobilapp@gmail.com",
                              () async =>
                                  await launch(_emailLaunchUri.toString())),
                          drawerCategory(
                            Icons.phone,
                            "55 1129 2554",
                            () async => await launch('tel:55 1129 2554'),
                          ),
                          Spacer(),
                          drawerCategory(Icons.logout, 'Cerrar Sesión',
                              () async {
                            logoutUser();
                            restaurants.fetchRestaurants();
                            user.disconnectUser();
                          }),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: wColorsBrand,
        child: SafeArea(
          child: CustomPaint(
            painter: DashboardPainter(),
            child: Padding(
              padding: wScreenPadding,
              child: DashBoardRoot(),
            ),
          ),
        ),
      ),
      // body: SafeArea(
      //   top: false,
      //   child: IndexedStack(
      //     index: _currentIndex,
      //     children: <Widget>[DashBoardRoot(), SettingsRoot()],
      //   ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Color.fromRGBO(53, 175, 46, 1),
      //   currentIndex: _currentIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: allDestinations.map((Destination destination) {
      //     return BottomNavigationBarItem(
      //         icon: Icon(destination.icon),
      //         backgroundColor: Colors.white,
      //         title: Text(destination.title));
      //   }).toList(),
      // ),
    );
  }

  Widget drawerCategory(IconData icon, String categoryTitle, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            icon != null ? Icon(icon) : Container(),
            icon != null ? SizedBox(width: 12) : Container(),
            Text(
              categoryTitle,
              style: wBlackDefaultText700,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<User>(User(), signalsReady: true);
  getIt.registerSingleton<Restaurants>(Restaurants(), signalsReady: true);
  getIt.registerSingleton<Restaurant>(Restaurant(), signalsReady: true);
  getIt.registerSingleton<SalesCuts>(SalesCuts(), signalsReady: true);
  getIt.registerSingleton<SalesMovements>(SalesMovements(), signalsReady: true);
  getIt.registerSingleton<SalesWaiters>(SalesWaiters(), signalsReady: true);
  getIt.registerSingleton<SalesWaiter>(SalesWaiter(), signalsReady: true);
  getIt.registerSingleton<DiscountsAccounts>(DiscountsAccounts(),
      signalsReady: true);
  getIt.registerSingleton<DiscountsProducts>(DiscountsProducts(),
      signalsReady: true);
  getIt.registerSingleton<CancellationsAccounts>(CancellationsAccounts(),
      signalsReady: true);
  getIt.registerSingleton<CancellationsProducts>(CancellationsProducts(),
      signalsReady: true);
  getIt.registerSingleton<ProductionProducts>(ProductionProducts(),
      signalsReady: true);
  getIt.registerSingleton<Assists>(Assists(), signalsReady: true);
  getIt.registerSingleton<TableStream>(TableStream(), signalsReady: true);
  getIt.registerSingleton<FiscalLog>(FiscalLog(), signalsReady: true);
  getIt.registerSingleton<PaymentMethods>(PaymentMethods(), signalsReady: true);
  getIt.registerSingleton<CancelledProductsProvider>(
      CancelledProductsProvider(),
      signalsReady: true);
  getIt.registerSingleton<CancelledAccountsProvider>(
      CancelledAccountsProvider(),
      signalsReady: true);
  getIt.registerSingleton<DiscountsProvider>(
      DiscountsProvider(),
      signalsReady: true);
  getIt.registerSingleton<AllNotifications>(
      AllNotifications(),
      signalsReady: true);
  getIt.registerSingleton<CancelledProductNotification>(
      CancelledProductNotification(),
      signalsReady: true);
  getIt.registerSingleton<CancelledAccountNotification>(
      CancelledAccountNotification(),
      signalsReady: true);
  getIt.registerSingleton<DiscountNotification>(
      DiscountNotification(),
      signalsReady: true);

  final user = getIt.get<User>();
  final allNotifications = getIt.get<AllNotifications>();
  final cancelledProductNotifications = getIt.get<CancelledProductNotification>();
  final cancelledAccountNotifications = getIt.get<CancelledAccountNotification>();
  final discountsNotifications = getIt.get<DiscountNotification>();
  await user.fetchUser();
  await allNotifications.areNotificationsEnabled();
  await cancelledProductNotifications.areNotificationsEnabled();
  await cancelledAccountNotifications.areNotificationsEnabled();
  await discountsNotifications.areNotificationsEnabled();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CancelledProductsProvider>(
          create: (_) => CancelledProductsProvider(),
        ),
        ChangeNotifierProvider<CancelledAccountsProvider>(
          create: (_) => CancelledAccountsProvider(),
        ),
        ChangeNotifierProvider<DiscountsProvider>(
          create: (_) => DiscountsProvider(),
        ),
        ChangeNotifierProvider<AllNotifications>(
          create: (_) => AllNotifications(),
        ),
        ChangeNotifierProvider<CancelledProductNotification>(
          create: (_) => CancelledProductNotification(),
        ),ChangeNotifierProvider<CancelledAccountNotification>(
          create: (_) => CancelledAccountNotification(),
        ),ChangeNotifierProvider<DiscountNotification>(
          create: (_) => DiscountNotification(),
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('es', ''),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Raleway",
          primaryColor: Color(0xFF5BAC43),
          accentColor: Color(0xFF5BAC43),
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF5BAC43),
          ),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
