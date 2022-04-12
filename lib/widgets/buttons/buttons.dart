import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const MainButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: Colors.black,
      ),
      onPressed: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
    );
  }
}
