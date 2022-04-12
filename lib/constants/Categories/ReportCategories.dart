enum ReportCategory {
  ventas,
  descuentos,
  cancelaciones,
  produccion,
  asistencias,
  bitacoraFiscal,
}

extension ReportCategoryExtension on ReportCategory {
  String get text {
    switch(this) {
      case ReportCategory.ventas:
        return 'Ventas';
        break;
      case ReportCategory.descuentos:
        return 'Descuentos';
        break;
      case ReportCategory.cancelaciones:
        return 'Cancelaciones';
        break;
      case ReportCategory.produccion:
        return 'Productos en producción';
        break;
      case ReportCategory.asistencias:
        return 'Asistencias';
        break;
      case ReportCategory.bitacoraFiscal:
        return 'Bitácora fiscal';
        break;
      default:
        return null;
    }
  }
}