import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class CustomTextField extends StatefulWidget {
  final MaskedTextController maskedTextController;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String placeholder;
  final String inputFor;
  final String label;
  final Icon prefixIcon;
  final bool shouldShowSuffixIconForPassword;
  final FocusNode focusNode;
  final Function onChanged;
  final Function validator;

  const CustomTextField(
      {Key key,
      InputDecoration decoration,
      this.placeholder,
      this.inputFor,
      this.prefixIcon,
      this.shouldShowSuffixIconForPassword = false,
      this.maskedTextController,
      this.keyboardType,
      this.textInputAction,
      this.textEditingController,
      this.focusNode,
      this.label,
      this.onChanged,
      this.validator})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = false;
  }

  void handleOnIconTap() {
    if (!widget.focusNode.hasFocus) {
      widget.focusNode.unfocus();
      widget.focusNode.canRequestFocus = false;
    }
    setState(() {
      showPassword = !showPassword;
    });
    Future.delayed(Duration.zero, () {
      widget.focusNode.canRequestFocus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Text(
            widget.label,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: -.24,
                color: Colors.white),
          ),
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              obscureText:
                  widget.shouldShowSuffixIconForPassword && !showPassword
                      ? true
                      : false,
              controller: widget.maskedTextController != null
                  ? widget.maskedTextController
                  : widget.textEditingController,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                fillColor: Colors.white.withOpacity(0.1),
                filled: true,
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w500),
                prefixIcon: widget.prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white54, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
            ),
            widget.shouldShowSuffixIconForPassword
                ? Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: InkWell(
                      child: showPassword
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onTap: handleOnIconTap,
                    ),
                )
                : Container(),
          ],
        )
      ],
    );
  }
}
