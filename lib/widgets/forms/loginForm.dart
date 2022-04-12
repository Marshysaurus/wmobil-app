import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wmobil/streams/User.dart';
import 'package:wmobil/utils/Auth.dart';
import 'package:wmobil/widgets/buttons/buttons.dart';
import 'package:wmobil/widgets/inputs/inputs.dart';

GetIt getIt = GetIt.instance;

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email = "";
  String _password = "";
  bool _formValid = false;
  bool _formWithErrors = false;
  String _emailFeedbackError;
  String _passwordFeedbackError;
  dynamic _error;

  final user = getIt.get<User>();

  _login() async {
    validate();

    if (_formValid) {
      var result = await loginUser(_email, _password);
      if (result is String) {
        setState(() {
          _error = result;
          _formWithErrors = true;
        });
        return;
      }

      await user.fetchUser();
    }
  }

  final _formKey = GlobalKey<FormState>();

  emailValidator(value) {
    if (value == null || value.isEmpty) {
      return "Introduce un correo electrónico";
    }

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailValid) {
      return "Introduce un correo electrónico válido";
    }

    return null;
  }

  passwordValidator(String value) {
    if (value == null || value.isEmpty) {
      return "Introduce una contraseña";
    }

    return null;
  }

  validate() {
    var emailValid = emailValidator(_email);
    var passwordValid = passwordValidator(_password);

    if (emailValid == null && passwordValid == null) {
      setState(() {
        _emailFeedbackError = emailValid;
        _passwordFeedbackError = passwordValid;
        _formValid = true;
      });
    } else {
      setState(() {
        _emailFeedbackError = emailValid;
        _passwordFeedbackError = passwordValid;
        _formValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextField(
            onChanged: (email) {
              setState(() {
                _email = email;
              });
            },
            label: "Correo",
            placeholder: "wmobil@gmail.com",
            prefixIcon: null,
            focusNode: FocusNode(),
          ),
          _emailFeedbackError != null ? SizedBox(height: 5) : Container(),
          _emailFeedbackError != null
              ? Text(
                  _emailFeedbackError,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            onChanged: (password) {
              setState(() {
                _password = password;
              });
            },
            label: "Contraseña",
            placeholder: "••••••••••",
            prefixIcon: null,
            shouldShowSuffixIconForPassword: true,
            focusNode: FocusNode(),
          ),
          _passwordFeedbackError != null ? SizedBox(height: 5) : Container(),
          _passwordFeedbackError != null
              ? Text(
                  _passwordFeedbackError,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )
              : Container(),
          SizedBox(height: 30),
          MainButton(
            text: "Iniciar sesión",
            onPressed: _login,
          ),
          SizedBox(height: 20),
          _formWithErrors
              ? Text(
                  "Error al iniciar sesión: $_error",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
