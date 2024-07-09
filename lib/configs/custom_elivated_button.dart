import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../static/color.dart';

class CustomElButton extends StatelessWidget {
  String buttoonname;
  Function? onclick;
  Color backColor;
  CustomElButton(
      {required this.buttoonname,
      this.onclick,
      this.backColor = Colo.yellowshade300,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
          onPressed: () => onclick!(),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide.none)),
            backgroundColor: MaterialStatePropertyAll(backColor),
            padding: MaterialStatePropertyAll(
              EdgeInsets.only(left: 10, right: 10),
            ),
          ),
          child: Text(
            buttoonname,
            style: TextStyle(color: Colo.black, fontWeight: FontWeight.bold),
          )),
    );
  }
}
