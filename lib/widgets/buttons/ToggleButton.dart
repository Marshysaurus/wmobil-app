import 'package:flutter/material.dart';

enum ToggleValues {
  Day,
  Period
}

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool filterByDay = true;

  void toggle() {
    setState(() {
      filterByDay = !filterByDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: 3,
            left:  filterByDay ? 0 : 60,
            right: filterByDay ? 60 : 0,
            child: InkWell(
              onTap: toggle,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    child: child,
                    scale: animation,
                  );
                },
                child: Icon(Icons.brightness_1, color: Colors.white, size: 35),
              ),
            ),
          )
        ],
      ),
    );
  }
}
