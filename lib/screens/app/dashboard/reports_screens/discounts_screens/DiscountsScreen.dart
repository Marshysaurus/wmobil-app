import 'package:flutter/material.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/discounts_screens/AccountsScreen.dart';
import 'package:wmobil/screens/app/dashboard/reports_screens/discounts_screens/ProductsScreen.dart';

class DiscountsScreen extends StatefulWidget {
  final String restaurantName;
  DiscountsScreen({this.restaurantName});

  @override
  _DiscountsScreenState createState() => _DiscountsScreenState();
}

class _DiscountsScreenState extends State<DiscountsScreen> {
  int _selectedDiscountsCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              reportsDiscountsCategoryContainer(
                text: 'Cuentas',
                option: 0,
                isOptionEnabled: true,
              ),
              SizedBox(width: 8),
              reportsDiscountsCategoryContainer(
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
            index: _selectedDiscountsCategory,
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

  Widget reportsDiscountsCategoryContainer(
      {String text, int option, bool isOptionEnabled}) {
    return Expanded(
      child: GestureDetector(
        onTap: isOptionEnabled
            ? () {
                if (_selectedDiscountsCategory != option)
                  setState(() {
                    _selectedDiscountsCategory = option;
                  });
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _selectedDiscountsCategory == option
                ? Colors.white
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: isOptionEnabled
                  ? (_selectedDiscountsCategory == option
                      ? Colors.transparent
                      : Colors.grey)
                  : Colors.black12,
            ),
            boxShadow: _selectedDiscountsCategory == option
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
                  ? (_selectedDiscountsCategory == option
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
