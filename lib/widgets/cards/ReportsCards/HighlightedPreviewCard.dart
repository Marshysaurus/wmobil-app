import 'package:flutter/material.dart';

// Internal imports
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/widgets/cards/RestaurantPreviewCard.dart';

class HighlightedPreviewCard extends StatelessWidget {
  final dynamic cardData;
  final dynamic cardInformationData;
  final int backgroundColor;
  final int titleColor;

  const HighlightedPreviewCard(
      {Key key,
      this.cardData,
      this.cardInformationData,
      this.backgroundColor = 0xFFFFFFFF,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(3, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              titleColor == 0xFFBD0900
                  ? Text(
                      "-",
                      style: wNegativeNumberStyle700,
                    )
                  : Container(),
              Text("\$",
                  style: titleColor == 0xFFBD0900
                      ? wNegativeNumberStyle700
                      : wNumberStyle700),
              Text(
                currencyFormat.format(cardData),
                style: titleColor == 0xFFBD0900
                    ? wNegativeNumberStyle700
                    : wNumberStyle700,
              ),
              Text(
                "MXN",
                style: titleColor == 0xFFBD0900
                    ? wRedSubtext700
                    : wGreenSubtext700,
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            cardInformationData,
            style: wBlackDefaultText700,
          )
        ],
      ),
    );
  }
}
