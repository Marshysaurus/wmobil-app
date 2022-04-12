import 'package:wmobil/widgets/buttons/DateLeadingButton.dart';

class RestaurantModel {
  final int id;
  final String title;
  final double commission;
  final DateTime lastFetched;
  // General restaurant info
  final List<dynamic> openTables;
  final List<dynamic> closedTables;
  final List<dynamic> cancelledTables;
  final List<dynamic> waiters;
  final List<dynamic> products;
  final List<dynamic> cancelledProducts;
  final List<dynamic> food;
  final List<dynamic> drinks;
  final List<dynamic> movements;
  final List<dynamic> turns;
  // Detailed restaurant info
  final double number;
  final double invoiced;
  final double costs;
  final int tablesOpen;
  final int cancellations;
  final double discounts;
  final int items;
  final int people;
  final double cash;
  final double card;
  final double tips;
  final double other;
  final double lastWeekTotal;
  final double lastMonthTotal;
  final double lastYearTotal;
  final int foodItems;
  final int drinkItems;
  final double foodRevenue;
  final double drinkRevenue;
  final double payed;
  final double prediction;
  final double utility;
  final double availableCash;
  final double cancelledAccounts;
  final double discountsPerProduct;
  final double discountsPerAccount;
  final double cancellationsPerProduct;
  final double cancellationsPerAccount;
  final List<dynamic> paymentMethods;

  RestaurantModel(
      {this.id,
      this.title,
      this.commission,
      this.lastFetched,
      this.number,
      this.invoiced,
      this.costs,
      this.tablesOpen,
      this.cancellations,
      this.discounts,
      this.items,
      this.people,
      this.openTables,
      this.closedTables,
      this.cancelledTables,
      this.waiters,
      this.cash,
      this.card,
      this.tips,
      this.other,
      this.lastWeekTotal,
      this.lastMonthTotal,
      this.lastYearTotal,
      this.foodItems,
      this.drinkItems,
      this.foodRevenue,
      this.drinkRevenue,
      this.payed,
      this.products,
      this.cancelledProducts,
      this.food,
      this.drinks,
      this.prediction,
      this.utility,
      this.availableCash,
      this.movements,
      this.turns,
      this.cancelledAccounts,
      this.cancellationsPerProduct,
      this.cancellationsPerAccount,
      this.discountsPerProduct,
      this.discountsPerAccount,
      this.paymentMethods});

  static RestaurantModel fromJSON(dynamic jsonData) {
    if (searchDate.leadingSearchDate.value == "online") {
      return RestaurantModel(
        id: jsonData["id"],
        title: jsonData["text"],
        commission: jsonData["comission"],
        lastFetched: DateTime.parse(jsonData["last_fetched"]).toLocal(),
        number:
            double.parse(jsonData[searchDate.leadingSearchDate.value]["total"]),
        invoiced: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["totalFacturado"]),
        costs: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["totalCostos"]),
        tablesOpen: int.parse(
            jsonData[searchDate.leadingSearchDate.value]["cuentasabiertas"]),
        cancellations: int.parse(
            jsonData[searchDate.leadingSearchDate.value]["cancelaciones"]),
        discounts: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["descuentos"]),
        items: int.parse(
            jsonData[searchDate.leadingSearchDate.value]["articulos"]),
        people: int.parse(
            jsonData[searchDate.leadingSearchDate.value]["comensales"]),
        openTables: jsonData["openTables"],
        closedTables: jsonData["closedTables"],
        cancelledTables: jsonData["cancelledTables"],
        waiters: jsonData["waiters"],
        cash: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["efectivo"]),
        card: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["tarjeta"]),
        tips: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["propina"]),
        other:
            double.parse(jsonData[searchDate.leadingSearchDate.value]["otros"]),
        lastWeekTotal: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["semana"]),
        lastMonthTotal:
            double.parse(jsonData[searchDate.leadingSearchDate.value]["mes"]),
        lastYearTotal:
            double.parse(jsonData[searchDate.leadingSearchDate.value]["year"]),
        foodItems: int.parse(
            jsonData[searchDate.leadingSearchDate.value]["articulos"]),
        drinkItems: int.parse(
            jsonData[searchDate.leadingSearchDate.value]["articulos"]),
        foodRevenue: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["alimentos"]),
        drinkRevenue: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["bebidas"]),
        payed: double.parse(jsonData[searchDate.leadingSearchDate.value]
            ["totalCuentasAbiertas"]),
        products: jsonData["products"],
        cancelledProducts: jsonData["cancelledProducts"],
        food: jsonData["food"],
        drinks: jsonData["drinks"],
        prediction: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["prediccion"] != "NAN"
                ? jsonData[searchDate.leadingSearchDate.value]["prediccion"]
                : "0"),
        utility:
            (jsonData[searchDate.leadingSearchDate.value]["utilidad"] as num)
                .toDouble(),
        availableCash: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["efectivoEnCaja"]),
        movements: jsonData["movements"],
        turns: jsonData["turnos"],
        cancelledAccounts: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["cuentascanceladas"]),
        paymentMethods: jsonData["payments"],
        cancellationsPerProduct: double.parse(
            jsonData[searchDate.leadingSearchDate.value]
                ["cancelaciones_productos"]),
        cancellationsPerAccount: double.parse(
            jsonData[searchDate.leadingSearchDate.value]
                ["cancelaciones_cuentas"]),
        discountsPerProduct: double.parse(
            jsonData[searchDate.leadingSearchDate.value]
                ["descuentos_productos"]),
        discountsPerAccount: double.parse(
            jsonData[searchDate.leadingSearchDate.value]["descuentos_cuentas"]),
      );
    } else {
      return RestaurantModel(
          id: jsonData["id"],
          title: jsonData["text"],
          commission: jsonData["comission"],
          lastFetched: DateTime.parse(jsonData["last_fetched"]).toLocal(),
          number: (jsonData[searchDate.leadingSearchDate.value]["total"] as num)
              .toDouble(),
          cash: (jsonData[searchDate.leadingSearchDate.value]["efectivo"] as num ?? 0)
              .toDouble(),
          card:
              (jsonData[searchDate.leadingSearchDate.value]["tarjeta"] as num ?? 0)
                  .toDouble(),
          other:
              (jsonData[searchDate.leadingSearchDate.value]["otros"] as num ?? 0)
                  .toDouble(),
          invoiced: (jsonData[searchDate.leadingSearchDate.value]
                      ["totalFacturado"] as num ??
                  0)
              .toDouble(),
          costs: (jsonData[searchDate.leadingSearchDate.value]["totalCostos"]
                      as num ??
                  0)
              .toDouble(),
          utility:
              (jsonData[searchDate.leadingSearchDate.value]["utilidad"] as num ??
                      0)
                  .toDouble());
    }
  }

  dynamic getInfo(String info) {
    if (info == "total") return this.number;
    if (info == "efectivo") return this.cash;
    if (info == "tarjeta") return this.card;
    if (info == "otros") return this.other;
    if (info == "totalFacturado") return this.invoiced;
    if (info == "totalCostos") return this.costs;
    if (info == "utilidad") return this.utility;
    if (info == "efectivoEnCaja" &&
        searchDate.leadingSearchDate.value == "online")
      return this.availableCash;
  }
}
