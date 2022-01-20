import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/ScreenWrappers/online_game_page_wrapper.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:velocity_x/velocity_x.dart';

Container containerForTournamentProfile(
    dynamic user, UserDataModel userOld, bool isMyTurn) {
  return Container(
    height: forHeight(155),
    width: width * 50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: forHeight(108),
              width: forHeight(108),
              decoration: BoxDecoration(
                  color: isMyTurn
                      ? Vx.hexToColor(userOld.accentColor.toString())
                      : Colors.transparent,
                  shape: BoxShape.circle),
            ).pOnly(top: forHeight(10)),
            Container(
              height: forHeight(100),
              width: forHeight(100),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          user.profilePhotoUrl.toString())),
                  shape: BoxShape.circle),
            ).pOnly(top: forHeight(10)),
          ],
        ),
        Text(
          user.username.toString(),
          style: TextStyle(
            fontSize: forHeight(20),
            color: isMyTurn
                ? Vx.hexToColor(userOld.accentColor.toString())
                : userOld.darkMode!
                    ? Vx.white
                    : Vx.gray400,
            fontWeight: isMyTurn ? FontWeight.w500 : null,
          ),
        )
      ],
    ),
  );
}

showCancelTournamentDialog(
    UserDataModel user, DocumentSnapshot anotherUser, BuildContext context) {
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
                "Exit the tournament?",
                style: TextStyle(
                    color: user.darkMode! ? Vx.white : Vx.black,
                    fontSize: forHeight(21),
                    fontWeight: FontWeight.w600),
              ).objectCenterLeft(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                      if (mySign == "o") {
                        Navigator.of(context).pop();
                        List<dynamic> anotherUserRequestsList =
                            anotherUser.get("requestsList");
                        anotherUserRequestsList.remove(user.uid);
                        await Database().dataCollection.doc(user.uid).update({
                          "acceptedRequestUserUid": "",
                        });
                        await Database()
                            .dataCollection
                            .doc(anotherUser.get("uid"))
                            .update({
                          "acceptedRequestUserUid": "",
                          "requestsList": anotherUserRequestsList
                        });
                      } else {
                        List<dynamic> userRequestsList = user.requestsList!;
                        userRequestsList.remove(anotherUser.get("uid"));
                        await Database()
                            .dataCollection
                            .doc(anotherUser.get("uid"))  
                            .update({
                          "acceptedRequestUserUid": "",
                          "oExit": true,
                        });
                        await Database().dataCollection.doc(user.uid).update({
                          "acceptedRequestUserUid": "",
                          "requestsList": userRequestsList,
                        });
                      }
                      await Database().dataCollection.doc(user.uid).update({
                        "checkboxes": ["", "", "", "", "", "", "", "", ""],
                      });
                      await Database()
                          .dataCollection
                          .doc(anotherUser.get("uid"))
                          .update({
                        "checkboxes": ["", "", "", "", "", "", "", "", ""],
                      });
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
