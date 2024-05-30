import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../static/color.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType KeyBoardType;
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final Function? validator;
  final Function? onChanged;
  final Icon? prefix;
  final bool? autofocus;

  CustomTextField(
      {required this.hint,
      required this.controller,
      required this.KeyBoardType,
      this.onChanged,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.prefix,
      this.autofocus = false});

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color currentColor = Colors.black38;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          keyboardType: widget.KeyBoardType,
          obscureText: widget.obscureText,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged!(text);
            }
            setState(() {
              if (text.length == 0) {
                currentColor = Colors.red;
              } else {
                // if (widget.validator!(text)) {
                //   currentColor = Colors.red;
                // }
                currentColor = Colors.black38;
              }
            });
          },

          //keyboardType: widget.inputType,
          controller: widget.controller,
          autofocus: widget.autofocus!,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.black38,
              fontSize: 15,
              // fontFamily: "OpenSans",
              // fontWeight: FontWeight.w300,
              letterSpacing: 0.1,
            ),
            border: InputBorder.none,
            hintText: widget.hint,
            prefixIcon: widget.prefix ?? widget.prefix,
          ),
        ),
      ),
    );
  }
}
