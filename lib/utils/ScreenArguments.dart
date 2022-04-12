class ScreenArguments {
  final String restaurantName;
  final DateTime lastFetched;
  final int showing;
  final int folio;
  final bool isOpen;
  final List<dynamic> movements;

  ScreenArguments(
      {this.restaurantName,
      this.lastFetched,
      this.showing,
      this.folio,
      this.isOpen,
      this.movements});
}
