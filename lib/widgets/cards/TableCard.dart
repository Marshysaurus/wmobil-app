import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmobil/constants/textStyles.dart';

final NumberFormat currencyFormat = new NumberFormat("#,##0.00", "en_US");
DateFormat format = DateFormat.Hms();

class TableCard extends StatelessWidget {
  final bool isOpen;
  final dynamic table;

  TableCard({Key key, this.isOpen, this.table}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '\$${currencyFormat.format(double.parse((table["totalconpropina"] as String).replaceAll(new RegExp(r','), '.')))}',
                style: wGreenProductCardTitle700,
              ),
              Spacer(),
              Text(
                "${table["totalarticulos"]}",
                style: wBlackCardNormalText500,
              ),
              Icon(
                Icons.fastfood,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "${table["nopersonas"]}",
                style: wBlackCardNormalText500,
              ),
              Icon(
                Icons.people,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: 8),
          table["cierre"] != null
              ? Text(
                  "Cierre: ${format.format(DateTime.parse(table["cierre"]).toLocal())}",
                  style: wBlackCardNormalText500,
                )
              : Container(),
          table["cierre"] != null ? SizedBox(height: 8) : Container(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  "${table["mesa"] != "" ? table["mesa"] : "S.N."} ${table["nombre"] != null ? "a cargo de " + table["nombre"] : ""}",
                  style: wBlackCardNormalText500,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 2,
                ),
              ),
              SizedBox(width: 10),
              !isOpen ? Text(
                "Folio: ",
                style: wGreyFolioText700,
              ) : Container(),
              !isOpen ? Text(
                "${table["numcheque"]}",
                style: wGreyFolioNumber400,
              ) : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
