import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/ScreenWrappers/online_game_page_wrapper.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:velocity_x/velocity_x.dart';

showExitDialog(UserDataModel user, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => Container(
            height: forHeight(140),
            width: forHeight(300),
            decoration: BoxDecoration(
                color: user.darkMode! ? Vx.black : Vx.white,
                borderRadius: BorderRadius.circular(forHeight(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quit the game?",
                  style: TextStyle(
                      color: user.darkMode! ? Vx.white : Vx.black,
                      fontSize: forHeight(23),
                      fontWeight: FontWeight.w600),
                ).objectCenterLeft(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => exit(0),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            color: user.darkMode! ? Vx.white : Vx.black,
                            fontSize: forHeight(23),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    sizedBoxForWidth(20),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "No",
                        style: TextStyle(
                            color: Vx.hexToColor(user.accentColor.toString()),
                            fontSize: forHeight(23),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ).pOnly(right: forWidth(5)),
              ],
            ).pSymmetric(v: forHeight(16), h: forWidth(10)),
          ).centered());
}

showCancelRequestDialog(UserDataModel user, String anotherUserUid,
    List<dynamic> anotherUserRequestList, BuildContext context) {
  showDialog(
    useRootNavigator: false,
    context: context,
    builder: (context) => Material(
        borderRadius: BorderRadius.circular(forHeight(8)),
        child: Container(
          height: forHeight(140),
          width: forHeight(300),
          decoration: BoxDecoration(
              color: user.darkMode!
                  ? Vx.hexToColor(user.accentColor.toString())
                  : Vx.white,
              borderRadius: BorderRadius.circular(forHeight(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cancle the request?",
                style: TextStyle(
                    color: user.darkMode! ? Vx.white : Vx.black,
                    fontSize: forHeight(23),
                    fontWeight: FontWeight.w600),
              ).objectCenterLeft(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Database()
                          .dataCollection
                          .doc(user.uid)
                          .update({"acceptedRequestUserUid": ""});
                      anotherUserRequestList.remove(user.uid);
                      await Database()
                          .dataCollection
                          .doc(anotherUserUid)
                          .update({"requestsList": anotherUserRequestList});
                      oneTimeAdd = true;
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                          color: user.darkMode! ? Vx.white : Vx.black,
                          fontSize: forHeight(23),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  sizedBoxForWidth(20),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "No",
                      style: TextStyle(
                          color: user.darkMode!
                              ? Vx.white
                              : Vx.hexToColor(user.accentColor.toString()),
                          fontSize: forHeight(23),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ).pOnly(right: forWidth(5)),
            ],
          ).pSymmetric(v: forHeight(16), h: forWidth(10)),
        )).centered(),
  );
}
