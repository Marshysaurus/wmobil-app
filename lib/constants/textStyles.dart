import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wmobil/constants/colors.dart';

// external imports
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

const wWhiteTitle700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 26,
  color: Colors.white,
);

const wGreenTitle700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 26,
  color: wColorsBrand,
);

const wBlackDialogContent500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 20,
  color: Colors.black,
);

const wGreenProductCardTitle700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  color: wColorsBrand,
);

const wGreenCardText700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 14,
  color: wColorsBrand,
);

const wGreenSubtext700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 10,
  color: wColorsBrand,
);

const wRedSubtext700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 10,
  color: Color(0xFFBD0900),
);

const wGreenButtonText500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 12,
  color: wColorsBrand,
);

const wWhiteSubtitle500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.white,
);

const wBlackOptionSelection500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.black,
);

const wGreyOptionSelection500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.grey,
);

const wBlackCardHeader500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 12,
  color: Colors.black,
);

const wGreyCardNormalText500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 14,
  color: Colors.grey,
);

const wBlackCardNormalText500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 14,
  color: Colors.black,
);

const wBlackCardSubtext500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 10,
  color: Colors.black,
);

const wGreyOptionSelectionDisabled500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.black12,
);

const wGreyTotalProductCard500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.black38,
);

const wGreyMXNProductCard500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 12,
  color: Colors.black38,
);

const wGreyFolioText700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 12,
  color: Colors.black38,
);

const wGreyFolioNumber400 = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: Colors.black38,
);

const wGreyHint500 = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 12,
  color: Colors.black26,
);

const wBlackLastUpdate400 = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 12,
  color: Colors.black,
);

const wWhiteButtonText700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  color: Colors.white,
);

const wBlackDefaultText700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 14,
  color: Colors.black,
);

const wGreenDefaultText700 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  color: wColorsBrand,
);

const wTextStyle300 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    letterSpacing: -.02,
    color: wColorsText300);

const wTextStyle300Caps = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    letterSpacing: -.02,
    color: wColorsText700);

const wTextStyle400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -.02,
    color: wColorsText400);

const wTextStyle400Caps = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -.02,
    color: wColorsText700);

const wTextStyle500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    letterSpacing: -.02,
    color: wColorsText700);

const wTextStyle700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: -.02,
    color: wColorsText700);

const wNumberStyle700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: -.02,
    color: wColorsBrand);

const wNegativeNumberStyle700 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: -.02,
    color: Color(0xFFBD0900));

const wTextStyle400Error = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: -.02,
    color: wColorsError);

const wTextStyleAppBar = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: -.02,
    color: Color.fromRGBO(33, 33, 33, 1));

final pw.TextStyle pwGreenRestaurantTitle700 = pw.TextStyle(
    fontWeight: pw.FontWeight.bold,
    fontSize: 26,
    color: PdfColor.fromHex('#5BAC43'));
final pw.TextStyle pwGreenText700 = pw.TextStyle(
    fontWeight: pw.FontWeight.bold,
    fontSize: 14,
    color: PdfColor.fromHex('#5BAC43'));
final pw.TextStyle pwWhiteColumnHeader700 = pw.TextStyle(
    fontWeight: pw.FontWeight.bold,
    fontSize: 16,
    color: PdfColor.fromHex('#FFFFFF'));
final pw.TextStyle pwBlackDocumentType500 = pw.TextStyle(
    fontWeight: pw.FontWeight.normal,
    fontSize: 20,
    color: PdfColor.fromHex('#000000'));
final pw.TextStyle pwBlackAdMessage500 = pw.TextStyle(
    fontWeight: pw.FontWeight.normal,
    fontSize: 12,
    color: PdfColor.fromHex('#000000'));
final pw.TextStyle pwBlackColumnBody500 = pw.TextStyle(
    fontWeight: pw.FontWeight.normal,
    fontSize: 16,
    color: PdfColor.fromHex('#000000'));
