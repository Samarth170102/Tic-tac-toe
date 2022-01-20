import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:velocity_x/velocity_x.dart';

Container userMenuOption(String optionName, String optionPng, bool darkMode) {
  return Container(
    color: darkMode ? Vx.black : Vx.white,
    child: Row(
      children: [
        Container(
          height:
              optionName == "About Us" || optionName == "Sign Out" ? 30 : 38,
          child: Image.asset("assets/images/bottombar/$optionPng.png",
              color: darkMode ? Vx.white : Vx.black),
        ),
        sizedBoxForWidth(optionName == "About Us" ? 13 : 10),
        Container(
          child: Text(
            optionName,
            style: TextStyle(
                fontSize: forHeight(20), color: darkMode ? Vx.white : Vx.black),
          ),
        ),
      ],
    ),
  );
}

InputDecoration inputDecorationEditProfile(
    EdgeInsets edgeInsets, UserDataModel user, BuildContext context) {
  return InputDecoration(
    contentPadding: edgeInsets,
    counterStyle: TextStyle(
        fontSize: forHeight(13), color: user.darkMode! ? Vx.white : Vx.gray400),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: forHeight(1.5),
        color: user.darkMode!
            ? Vx.hexToColor(user.accentColor.toString())
            : Vx.black.withOpacity(0.8),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: forHeight(1.5),
        color: user.darkMode! ? Vx.white : Vx.black.withOpacity(0.8),
      ),
    ),
  );
}

Padding rowForUserDetails(String type, String value, bool darkMode) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(
      type,
      style: TextStyle(
        color: darkMode ? Vx.white : Vx.black,
        fontSize: forHeight(17),
      ),
    ),
    Text(
      value,
      style: TextStyle(
        color: darkMode ? Vx.white : Vx.black,
        fontSize: forHeight(17),
      ),
    )
  ]).pOnly(top: forHeight(32));
}

Material optionBoxForHomePage(String text) {
  return Material(
    borderRadius: BorderRadius.circular(
      forHeight(8),
    ),
    elevation: forHeight(2),
    child: Container(
      height: forHeight(78),
      width: forHeight(175),
      child: Text(
        text,
        style: TextStyle(
          fontSize: forHeight(24),
          fontWeight: FontWeight.w500,
        ),
      ).centered(),
      decoration: BoxDecoration(
        color: Vx.white,
        borderRadius: BorderRadius.circular(
          forHeight(8),
        ),
      ),
    ),
  );
}
