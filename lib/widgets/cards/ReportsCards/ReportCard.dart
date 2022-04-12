import 'package:flutter/material.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';

class ReportCard extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final String path;

  ReportCard({this.image, this.title, this.color, this.path});

  void onTapRedirect(BuildContext context) {
    Navigator.of(context).pushNamed(path);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: path != null ? 15 : 0,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: path != null ? () {
          onTapRedirect(context);
        } : null,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: image != null ? Image.asset(image) : Text(title, style: wTextStyle700),
          ),
        ),
      ),
    );
  }
}
