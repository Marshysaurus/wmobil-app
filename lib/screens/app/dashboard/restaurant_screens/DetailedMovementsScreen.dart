import 'package:flutter/material.dart';
import 'package:wmobil/constants/colors.dart';
import 'package:wmobil/constants/textStyles.dart';
import 'package:wmobil/utils/CustomPainter/DashboardPainter.dart';
import 'package:wmobil/widgets/cards/SpecificMovementCard.dart';

class DetailedMovementsScreen extends StatefulWidget {
  final String restaurantName;
  final List<dynamic> movements;

  DetailedMovementsScreen({this.restaurantName, this.movements});

  @override
  _DetailedMovementsScreenState createState() =>
      _DetailedMovementsScreenState();
}

class _DetailedMovementsScreenState extends State<DetailedMovementsScreen> {
  Map<int, int> rankMap = Map();

  void rankMovements() {
    List<int> ranking = [];
    int rank = 1;

    widget.movements.forEach((element) {
      ranking.add(element['idturno']);
    });

    ranking.sort((int b, int a) {
      return b.compareTo(a);
    });

    for (int i = 0; i < ranking.length; i++) {
      int element = ranking[i];

      if (!rankMap.containsKey(element)) {
        rankMap[element] = rank;
        rank++;
      }
    }
  }

  @override
  void initState() {
    rankMovements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.movements.sort((b, a) {
      var aDate = a['fecha'];
      var bDate = b['fecha'];
      return bDate.compareTo(aDate);
    });

    return Scaffold(
      body: Container(
        color: wColorsBrand,
        child: SafeArea(
          child: CustomPaint(
            painter: DashboardPainter(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 14),
                      Text(
                        widget.restaurantName,
                        style: wWhiteSubtitle500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    "Detalles de movimientos",
                    style: wWhiteTitle700,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: widget.movements
                          .map((movement) => SpecificMovementCard(
                                movement: movement,
                                ranking: rankMap[movement["idturno"]],
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
