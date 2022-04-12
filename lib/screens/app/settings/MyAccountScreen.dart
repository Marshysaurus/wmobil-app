import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/streams/Restaurants.dart';
import 'package:wmobil/streams/User.dart';
import 'package:wmobil/utils/Auth.dart';

// Internal imports
import 'package:wmobil/widgets/tiles/tiles.dart';

GetIt getIt = GetIt.instance;

class MyAccountScreen extends StatelessWidget {
  final user = getIt.get<User>();
  final restaurants = getIt.get<Restaurants>();

  logOut() async {
    logoutUser();
    restaurants.fetchRestaurants();
    await user.fetchUser();
  }

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
          title: Text("Mi cuenta",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: -.02,
                  color: Color.fromRGBO(33, 33, 33, 1))),
        ),
        body: SafeArea(
            child: StreamBuilder(
                stream: user.stream$,
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.data == null) {
                    return Container();
                  }
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: ListView(children: <Widget>[
                          Container(
                            child: InformationTile(
                              title:
                                  "${snap.data["name"] + " " + snap.data["lastName"]}",
                            ),
                          ),
                          Container(
                            child: InformationTile(
                              title: "${snap.data["email"]}",
                            ),
                          ),
                          Container(
                              child: ActionTile(
                            onTap: logOut,
                            icon: Icons.exit_to_app,
                            title: "Cerrar sesión",
                            color: Color.fromRGBO(224, 104, 118, 1),
                          )),
                        ]))
                      ],
                    ),
                  );
                })));
  }
}
