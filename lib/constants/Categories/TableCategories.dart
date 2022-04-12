enum TableCategory {
  cuentasAbiertas,
  cuentasCerradas,
  topMeseros,
  topProductos,
  topAlimentos,
  topBebidas,
  productosCancelados,
  cuentasCanceladas,
}

extension TableCategoryExtension on TableCategory {
  String get text {
    switch (this) {
      case TableCategory.cuentasAbiertas:
        return 'Cuentas abiertas';
        break;
      case TableCategory.cuentasCerradas:
        return 'Cuentas cerradas';
        break;
      case TableCategory.topMeseros:
        return 'Top meseros';
        break;
      case TableCategory.topProductos:
        return 'Top productos';
        break;
      case TableCategory.topAlimentos:
        return 'Top alimentos';
        break;
      case TableCategory.topBebidas:
        return 'Top bebidas';
        break;
      case TableCategory.productosCancelados:
        return 'Productos cancelados';
        break;
      case TableCategory.cuentasCanceladas:
        return 'Cuentas canceladas';
        break;
      default:
        return null;
    }
  }
}
