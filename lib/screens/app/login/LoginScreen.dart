import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wmobil/constants/colors.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/widgets/forms/loginForm.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: wColorsBrand,
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/screens/login/background.jpg"),
                    fit: BoxFit.cover,
                  )),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Row(
                        children: <Widget>[
                          Text(
                            "Bienvenido",
                            style: wWhiteTitle700,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Inicia sesión para continuar",
                              style: wWhiteSubtitle500,
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      LoginForm(),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Wmobil",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "v2.5.0",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset("assets/logo-white.svg"),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
