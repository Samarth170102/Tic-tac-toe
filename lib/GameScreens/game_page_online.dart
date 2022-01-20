// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/ScreenWrappers/online_game_page_wrapper.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/game_logic.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets6.dart';
import 'package:flutter_application_9/main.dart';
import 'package:velocity_x/velocity_x.dart';

class OnlineTournament extends StatefulWidget {
  UserDataModel userOld = UserDataModel();
  String anotherUserUid = "";
  OnlineTournament(this.userOld, this.anotherUserUid);
  @override
  _OnlineTournamentState createState() => _OnlineTournamentState();
}

class _OnlineTournamentState extends State<OnlineTournament> {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [SetStateMutation]);
    final userOld = widget.userOld;
    return StreamBuilder<DocumentSnapshot>(
      stream: Database().dataCollection.doc(widget.anotherUserUid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot anotherUser = snapshot.data;
          return StreamBuilder<UserDataModel>(
              stream: Database().docsSnap,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  UserDataModel user = snapshot.data;
                  String userUid = user.uid.toString();
                  String anotherUserUid = anotherUser.get("uid");
                  bool isMyTurn = user.myTurn!;
                  AnotherUserClass(
                    anotherUser.get("username"),
                    anotherUser.get("profilePhotoUrl"),
                  );
                  List<dynamic> myCheckboxes = user.checkboxes!.toList();
                  if (!isWin) {
                    checkWinForTournament(myCheckboxes,
                        user.accentColor.toString(), user, anotherUser);
                  }
                  if (!myCheckboxes.contains("o") &&
                      !myCheckboxes.contains("x")) {
                    isWin = false;
                  }
                  if (user.acceptedRequestUserUid == "" &&
                      anotherUser.get("acceptedRequestUserUid") == "") {
                    Navigator.pop(context);
                  }
                  return WillPopScope(
                    onWillPop: () async {
                      showCancelTournamentDialog(user, anotherUser, context);
                      return false;
                    },
                    child: Scaffold(
                      backgroundColor: userOld.darkMode! ? Vx.black : Vx.white,
                      appBar: appBarForAuth(
                          mode: userOld.darkMode, toolbarHeight: 0),
                      body: Column(
                        children: [
                          Row(children: [
                            GestureDetector(
                                onTap: () => showCancelTournamentDialog(
                                    user, anotherUser, context),
                                child: Container(
                                    height: 5.72921 * height,
                                    width: 5.72921 * height,
                                    child: Align(
                                      child: Image.asset(
                                        "assets/images/bottombar/back.png",
                                        color: user.darkMode!
                                            ? Vx.white
                                            : Vx.black,
                                      ).pSymmetric(h: 1.6082 * height),
                                    ))),
                            Container(
                              child: Text(
                                "Tournament",
                                style: TextStyle(
                                    color: user.darkMode! ? Vx.white : Vx.black,
                                    fontSize: 2.61332 * height,
                                    fontWeight: FontWeight.w500),
                              ),
                            ).pOnly(bottom: 0.20102 * height),
                          ]),
                          Row(children: [
                            containerForTournamentProfile(
                                user, userOld, isMyTurn),
                            containerForTournamentProfile(
                                AnotherUserClass(
                                  anotherUser.get("username"),
                                  anotherUser.get("profilePhotoUrl"),
                                ),
                                userOld,
                                !isMyTurn)
                          ]),
                          sizedBoxForHeight(40),
                          isWin
                              ? Container(
                                  height: forHeight(28),
                                  child: Text(winner,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: Vx.hexToColor(
                                              user.accentColor.toString()))))
                              : Container(
                                  height: forHeight(28),
                                  width: width * 5,
                                ),
                          sizedBoxForHeight(35),
                          Stack(
                            children: [
                              Container(
                                  height: forHeight(330),
                                  child: Image.asset(
                                    "assets/images/game/tic_tac_toe_border.png",
                                    color:
                                        user.darkMode! ? Vx.white : Vx.gray400,
                                  )),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  0,
                                  0,
                                  0,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  1,
                                  0,
                                  110,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  2,
                                  0,
                                  220,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  3,
                                  111,
                                  0,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  4,
                                  111,
                                  110,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  5,
                                  111,
                                  220,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  6,
                                  222,
                                  0,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  7,
                                  222,
                                  110,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                              positionedBoxForGameTournament(
                                  myCheckboxes,
                                  isMyTurn,
                                  userUid,
                                  anotherUserUid,
                                  user.username.toString(),
                                  anotherUser.get("username"),
                                  8,
                                  222,
                                  220,
                                  user.darkMode!,
                                  user.accentColor!,
                                  context),
                            ],
                          ),
                          sizedBoxForHeight(85),
                          Container(
                            child: isWin
                                ? GestureDetector(
                                    onTap: () {
                                      Database()
                                          .dataCollection
                                          .doc(userUid)
                                          .update({
                                        "checkboxes": [
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          ""
                                        ],
                                        "myTurn": isMyTurn
                                      });
                                      Database()
                                          .dataCollection
                                          .doc(anotherUserUid)
                                          .update({
                                        "checkboxes": [
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          ""
                                        ],
                                        "myTurn": !isMyTurn
                                      });
                                    },
                                    child: Container(
                                        child: Text(" Restart Tournament?",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Vx.hexToColor(user
                                                    .accentColor
                                                    .toString())))),
                                  )
                                : Container(
                                    height: forHeight(42),
                                    width: forWidth(1),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return loadingWidget(
                      accentColor: userOld.accentColor, mode: userOld.darkMode);
                }
              });
        } else {
          return loadingWidget(
              accentColor: userOld.accentColor, mode: userOld.darkMode);
        }
      },
    );
  }
}

class AnotherUserClass {
  String username;
  String profilePhotoUrl;
  AnotherUserClass(
    this.username,
    this.profilePhotoUrl,
  );
}

Positioned positionedBoxForGameTournament(
    List<dynamic> myCheckboxes,
    bool isMyTurn,
    String userUid,
    String anotherUserUid,
    String username,
    String otherUsername,
    int index,
    double top,
    double left,
    bool darkMode,
    String accentColor,
    BuildContext context) {
  bool isCross = myCheckboxes[index] == "x";
  return Positioned(
    top: top,
    left: left,
    child: GestureDetector(
      onTap: () async {
        if (isMyTurn) {
          if (!isWin) {
            if (myCheckboxes[index] == "") {
              myCheckboxes[index] = mySign;
              Database()
                  .dataCollection
                  .doc(anotherUserUid)
                  .update({"checkboxes": myCheckboxes, "myTurn": isMyTurn});
              Database()
                  .dataCollection
                  .doc(userUid)
                  .update({"checkboxes": myCheckboxes, "myTurn": !isMyTurn});
            }
          }
        }
      },
      child: myCheckboxes[index] != ""
          ? Container(
              height: forHeight(111),
              width: forHeight(111),
              color: Colors.transparent,
              child: Image.asset(
                "assets/images/game/${myCheckboxes[index]}.png",
                color: isCross
                    ? darkMode
                        ? Vx.red500
                        : Vx.red400
                    : darkMode
                        ? Vx.blue500
                        : Vx.blue400,
              ).pSymmetric(h: forHeight(isCross ? 19 : 17)),
            )
          : Container(
              height: forHeight(111),
              width: forHeight(111),
              color: Colors.transparent,
            ),
    ),
  );
}
