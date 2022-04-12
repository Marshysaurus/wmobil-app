import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';
// Internal imports
import 'package:wmobil/screens/app/dashboard/reports_screens/sales_screens/CutsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/sales_screens/MovementsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/sales_screens/WaitersScreen.dart';

class SalesScreen extends StatefulWidget {
  final String restaurantName;
  SalesScreen({this.restaurantName});

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  int _selectedSalesCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              reportsSalesCategoryContainer(
                text: 'Cortes',
                option: 0,
                isOptionEnabled: true,
              ),
              SizedBox(width: 8),
              reportsSalesCategoryContainer(
                text: 'Movimientos',
                option: 1,
                isOptionEnabled: true,
              ),
              // SizedBox(width: 8),
              // reportsSalesCategoryContainer(
              //   text: 'Meseros',
              //   option: 2,
              //   isOptionEnabled: false,
              // ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: IndexedStack(
            index: _selectedSalesCategory,
            children: [
              CutsScreen(
                restaurantName: widget.restaurantName,
              ),
              MovementsScreen(
                restaurantName: widget.restaurantName,
              ),
              WaitersScreen(
                restaurantName: widget.restaurantName,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget reportsSalesCategoryContainer(
      {String text, int option, bool isOptionEnabled}) {
    return Expanded(
      child: GestureDetector(
        onTap: isOptionEnabled
            ? () {
                if (_selectedSalesCategory != option)
                  setState(() {
                    _selectedSalesCategory = option;
                  });
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _selectedSalesCategory == option
                ? Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: isOptionEnabled
                  ? (_selectedSalesCategory == option
                      ? Colors.transparent
                      : Colors.grey)
                  : Colors.black12,
            ),
            boxShadow: _selectedSalesCategory == option
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
                  ? (_selectedSalesCategory == option
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
