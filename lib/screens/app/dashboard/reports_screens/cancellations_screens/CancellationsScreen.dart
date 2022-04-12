import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/cancellations_screens/AccountsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/cancellations_screens/ProductsScreen.dart';

class CancellationsScreen extends StatefulWidget {
  final String restaurantName;
  CancellationsScreen({this.restaurantName});

  @override
  _CancellationsScreenState createState() => _CancellationsScreenState();
}

class _CancellationsScreenState extends State<CancellationsScreen> {
  int _selectedCancellationsCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              reportsCancellationsCategoryContainer(
                text: 'Cuentas',
                option: 0,
                isOptionEnabled: true,
              ),
              SizedBox(width: 8),
              reportsCancellationsCategoryContainer(
                text: 'Productos',
                option: 1,
                isOptionEnabled: true,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: IndexedStack(
            index: _selectedCancellationsCategory,
            children: [
              AccountsScreen(
                restaurantName: widget.restaurantName,
              ),
              ProductsScreen(
                restaurantName: widget.restaurantName,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget reportsCancellationsCategoryContainer(
      {String text, int option, bool isOptionEnabled}) {
    return Expanded(
      child: GestureDetector(
        onTap: isOptionEnabled
            ? () {
                if (_selectedCancellationsCategory != option)
                  setState(() {
                    _selectedCancellationsCategory = option;
                  });
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _selectedCancellationsCategory == option
                ? Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: isOptionEnabled
                  ? (_selectedCancellationsCategory == option
                      ? Colors.transparent
                      : Colors.grey)
                  : Colors.black12,
            ),
            boxShadow: _selectedCancellationsCategory == option
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(3, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: isOptionEnabled
                  ? (_selectedCancellationsCategory == option
                      ? wBlackOptionSelection500
                      : wGreyOptionSelection500)
                  : wGreyOptionSelectionDisabled500,
            ),
          ),
        ),
      ),
    );
  }
}
