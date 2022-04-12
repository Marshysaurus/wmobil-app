import 'package:flutter/material.dart';
// External imports
import 'package:intl/intl.dart';
// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/widgets/buttons/other/BlinkingCircle.dart';

enum LeadingDate { Live, Week, Month, Year }

extension Button on LeadingDate {
  Widget get button {
    switch (this) {
      case LeadingDate.Live:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'En vivo',
              style: searchDate.leadingSearchDate == LeadingDate.Live ? wBlackOptionSelection500 : wGreyOptionSelection500,
            ),
            SizedBox(width: 5),
            BlinkingCircle()
          ],
        );
        break;
      case LeadingDate.Week:
        return Center(
          child: Text(
            'Semana',
            style: searchDate.leadingSearchDate == LeadingDate.Week ? wBlackOptionSelection500 : wGreyOptionSelection500,
          ),
        );
        break;
      case LeadingDate.Month:
        return Center(
          child: Text(
            'Mes',
            style: searchDate.leadingSearchDate == LeadingDate.Month ? wBlackOptionSelection500 : wGreyOptionSelection500,
          ),
        );
        break;
      case LeadingDate.Year:
        return Center(
          child: Text(
            'Año',
            style: searchDate.leadingSearchDate == LeadingDate.Year ? wBlackOptionSelection500 : wGreyOptionSelection500,
          ),
        );
        break;
      default:
        return null;
    }
  }

  bool get boolean {
    switch (this) {
      case LeadingDate.Live:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  String get value {
    switch (this) {
      case LeadingDate.Live:
        return "online";
        break;
      case LeadingDate.Week:
        return "week";
        break;
      case LeadingDate.Month:
        return "month";
        break;
      case LeadingDate.Year:
        return "year";
        break;
      default:
        return null;
        break;
    }
  }

  String get message {
    DateTime today = DateTime.now();
    DateFormat format = DateFormat(DateFormat.YEAR_MONTH_DAY, 'es');
    switch (this) {
      case LeadingDate.Live:
        return format.format(today);
        break;
      case LeadingDate.Week:
        return format.format(today.subtract(Duration(days: today.weekday - 1)));
        break;
      case LeadingDate.Month:
        return format.format(today.subtract(Duration(days: today.day - 1)));
        break;
      case LeadingDate.Year:
        return format.format(DateTime(today.year));
        break;
      default:
        return null;
        break;
    }
  }
}

class SearchDate with ChangeNotifier {
  LeadingDate leadingSearchDate = LeadingDate.values[0];

  static final SearchDate _searchDate = SearchDate._internal();

  SearchDate._internal();

  factory SearchDate() {
    return _searchDate;
  }
}

final searchDate = SearchDate();
