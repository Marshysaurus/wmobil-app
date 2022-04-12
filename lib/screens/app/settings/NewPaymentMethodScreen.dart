import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

// External imports
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:stripe_payment/stripe_payment.dart';
import 'package:wmobil/utils/PaymentMethods.dart';
import 'package:wmobil/widgets/buttons/buttons.dart';

// Internal imports
import 'package:wmobil/widgets/inputs/inputs.dart';

class NewPaymentMethodScreen extends StatefulWidget {
  const NewPaymentMethodScreen({
    Key key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    @required this.onCreditCardModelChange,
    this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;

  @override
  _NewPaymentMethodScreenState createState() => _NewPaymentMethodScreenState();
}

class _NewPaymentMethodScreenState extends State<NewPaymentMethodScreen> {
  // final _formKey = GlobalKey<FormState>();
  // bool _autoValidate = false;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  CreditCardModel creditCardModel;

  // Masks for text fields
  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_gnxl4YJ44qSg7jv55fXjKbIM00KzPN9c6Z",
        merchantId: "Test",
        androidPayMode: 'test'));

    createCreditCardModel();

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  onSubmit(CreditCardModel cardData, BuildContext context) async {
    final CreditCard card = CreditCard(
        name: cardData.cardHolderName,
        number: cardData.cardNumber,
        cvc: cardData.cvvCode,
        expMonth: int.parse(cardData.expiryDate.split("/")[0]),
        expYear: int.parse(cardData.expiryDate.split("/")[1]));

    var token = await StripePayment.createTokenWithCard(
      card,
    );

    var response = await addPaymentMethod(token.tokenId);

    if (response["setupIntent"]["next_action"] == null) {
      setState(() {
        cardNumber = "";
        expiryDate = "";
        cardHolderName = "";
        cvvCode = "";
        isCvvFocused = false;
      });

      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) => CupertinoAlertDialog(
                title: Text("Método de pago agregado"),
              )).then((val) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: new IconButton(
            hoverColor: Colors.black,
            iconSize: 16,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text("Nuevo método de pago",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  letterSpacing: -.02,
                  color: Color.fromRGBO(33, 33, 33, 1))),
        ),
        body: SafeArea(
            child: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: CreditCardWidget(
                      cardBgColor: Color.fromRGBO(95, 90, 183, 1),
                      width: double.infinity,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      textStyle: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, .9),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
                    ),
                  ),
                  Container(
                      child: Form(
                          child: Column(children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: CustomTextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textEditingController: _cardHolderNameController,
                          prefixIcon: new Icon(
                            Icons.person,
                            color: Color.fromRGBO(128, 128, 128, 1),
                          ),
                          placeholder: "John Doe",
                          inputFor: "cardHolderName",
                          label: "Nombre del titular",
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maskedTextController: _cardNumberController,
                          prefixIcon: new Icon(
                            Icons.credit_card,
                            color: Color.fromRGBO(128, 128, 128, 1),
                          ),
                          label: "Número de la tarjeta",
                          placeholder: "XXXX XXXX XXXX XXXX",
                          inputFor: "cardNumber",
                        )),
                    Container(
                      child: Row(children: [
                        Flexible(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: CustomTextField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  maskedTextController: _expiryDateController,
                                  prefixIcon: new Icon(
                                    Icons.calendar_today,
                                    color: Color.fromRGBO(128, 128, 128, 1),
                                  ),
                                  label: "Fecha de vencimiento",
                                  placeholder: "MM/YY",
                                  inputFor: "expiryDate",
                                ))),
                        Flexible(
                            flex: 1,
                            child: CustomTextField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              maskedTextController: _cvvCodeController,
                              prefixIcon: null,
                              label: "CVV",
                              placeholder: "XXX(X)",
                              inputFor: "cvv",
                              focusNode: cvvFocusNode,
                              onChanged: (String text) {
                                setState(() {
                                  cvvCode = text;
                                });
                              },
                            ))
                      ]),
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        child: MainButton(
                          text: "Añadir tarjeta",
                          onPressed: () {
                            onSubmit(creditCardModel, context);
                          },
                        ))
                  ]))),
                ])))));
  }
}
