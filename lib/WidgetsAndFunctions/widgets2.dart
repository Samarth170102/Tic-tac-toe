import 'package:flutter/material.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:velocity_x/velocity_x.dart';

Container themeBox(String text, Color textColor, String backgroundColor) {
  return Container(
    height: 5.8307 * height,
    width: 9.96382 * height,
    child: Text(
      text,
      style: TextStyle(
          fontSize: 2.1107 * height,
          fontWeight: FontWeight.w600,
          color: textColor),
    ).centered(),
    decoration: BoxDecoration(
        color: Vx.hexToColor(backgroundColor),
        borderRadius: BorderRadius.circular(1.00512 * height)),
  );
}

BottomNavigationBarItem bottomNavigationBarItem(String text, String iconName,
    int myIndex, int screenIndex, bool darkMode, String accentColor) {
  return BottomNavigationBarItem(
    label: text,
    icon: Container(
      height: myIndex == screenIndex ? height * 3.3 : height * 3,
      child: Image.asset(
        "assets/images/bottombar/$iconName.png",
        color: myIndex == screenIndex
            ? Vx.hexToColor(accentColor)
            : darkMode
                ? Vx.white
                : Vx.gray500,
      ),
    ),
  );
}

Row rowforHeadingInEditProfile(
    String heading, bool darkMode, BuildContext context,
    {Function? function}) {
  return Row(children: [
    GestureDetector(
        onTap: () async {
          if (function != null) {
            function();
          }
          Navigator.pop(context);
        },
        onDoubleTap: () {
          if (function != null) {
            function();
          }
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        child: Container(
            height: 5.72921 * height,
            width: 5.72921 * height,
            child: Align(
              child: Image.asset(
                "assets/images/bottombar/back.png",
                color: darkMode ? Vx.white : Vx.black,
              ).pSymmetric(h: 1.6082 * height),
            ))),
    Container(
      child: Text(
        heading,
        style: TextStyle(
            color: darkMode ? Vx.white : Vx.black,
            fontSize: 2.61332 * height,
            fontWeight: FontWeight.w500),
      ),
    ).pOnly(bottom: 0.20102 * height),
  ]);
}

Material containerForUserProfile(String text) {
  return Material(
    elevation: forHeight(2.5),
    borderRadius: BorderRadius.circular(forHeight(6)),
    child: Container(
      height: forHeight(100),
      width: width * 46.4,
      child: Text(
        text,
        style: TextStyle(fontSize: forHeight(25), fontWeight: FontWeight.w500),
      ).centered(),
      decoration: BoxDecoration(
          color: Vx.white, borderRadius: BorderRadius.circular(forHeight(6))),
    ),
  );
}
