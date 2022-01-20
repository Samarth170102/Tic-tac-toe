// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/game_logic.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets2.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:velocity_x/velocity_x.dart';

class GamePage2Players extends StatefulWidget {
  UserDataModel user = UserDataModel();
  GamePage2Players(this.user);
  @override
  _GamePage2PlayersState createState() => _GamePage2PlayersState();
}

beforeExitGame2Players() {
  checkboxes = ["", "", "", "", "", "", "", "", ""];
  isWin = false;
  bool is1stPlayerTurn = true;
}

class _GamePage2PlayersState extends State<GamePage2Players> {
  bool isEasy = true;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    VxState.watch(context, on: [SetStateMutation]);
    return WillPopScope(
      onWillPop: () async {
        checkboxes = ["", "", "", "", "", "", "", "", ""];
        isWin = false;
        is1stPlayerTurn = true;
        return true;
      },
      child: Scaffold(
        backgroundColor: user.darkMode! ? Vx.black : Vx.white,
        appBar: appBarForAuth(toolbarHeight: 0, mode: user.darkMode),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rowforHeadingInEditProfile(
                "Play 2 Players", user.darkMode!, context,
                function: beforeExitGame2Players),
            sizedBoxForHeight(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "   1st Player:  ",
                          style: TextStyle(
                              fontSize: forHeight(20),
                              color: user.darkMode! ? Vx.white : Vx.black),
                        ),
                        Container(
                          height: forHeight(30),
                          child: Image.asset(
                            "assets/images/game/o.png",
                            color: user.darkMode! ? Vx.blue500 : Vx.blue400,
                          ),
                        )
                      ],
                    ),
                    sizedBoxForHeight(10),
                    Row(
                      children: [
                        Text(
                          "   2nd Player: ",
                          style: TextStyle(
                              fontSize: forHeight(20),
                              color: user.darkMode! ? Vx.white : Vx.black),
                        ).pOnly(right: forWidth(3)),
                        Container(
                          height: forHeight(30),
                          child: Image.asset(
                            "assets/images/game/x.png",
                            color: user.darkMode! ? Vx.red500 : Vx.red400,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    checkboxes = ["", "", "", "", "", "", "", "", ""];
                    isWin = false;
                    is1stPlayerTurn = true;
                    setState(() {});
                  },
                  child:
                      !checkboxes.contains("o") && !checkboxes.contains("x") ||
                              isWin
                          ? Container(
                              height: forHeight(35),
                              child: Image.asset(
                                "assets/images/bottombar/restart.png",
                                color: Vx.hexToColor(user.accentColor!),
                              ),
                            ).pOnly(bottom: forHeight(7), right: forWidth(12))
                          : Container(
                              height: forHeight(42),
                              width: forWidth(1),
                            ),
                )
              ],
            ),
            sizedBoxForHeight(120),
            Stack(
              children: [
                Container(
                    height: forHeight(330),
                    child: Image.asset(
                      "assets/images/game/tic_tac_toe_border.png",
                      color: user.darkMode! ? Vx.white : Vx.gray400,
                    )),
                positionedBoxForGame2Players(
                    0, 0, 0, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    1, 0, 110, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    2, 0, 220, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    3, 111, 0, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    4, 111, 110, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    5, 111, 220, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    6, 222, 0, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    7, 222, 110, user.darkMode!, user.accentColor!, context),
                positionedBoxForGame2Players(
                    8, 222, 220, user.darkMode!, user.accentColor!, context),
              ],
            )
          ],
        ).wFull(context),
      ),
    );
  }
}

Positioned positionedBoxForGame2Players(int index, double top, double left,
    bool darkMode, String accentColor, BuildContext context) {
  bool isCross = checkboxes[index] == "x";
  return Positioned(
    top: top,
    left: left,
    child: GestureDetector(
      onTap: () async {
        if (is1stPlayerTurn) {
          if (!isWin) {
            if (checkboxes[index] == "") {
              checkboxes[index] = "o";
              checkWinFor2Players(accentColor, context);
              is1stPlayerTurn = false;
              SetStateMutation();
            }
          }
        }
      },
      child: checkboxes[index] != ""
          ? Container(
              height: forHeight(111),
              width: forHeight(111),
              color: Colors.transparent,
              child: Image.asset(
                "assets/images/game/${checkboxes[index]}.png",
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

void cpuChoose() {
  Random rand = Random();
  int randIndex = rand.nextInt(9);
  checkboxes[randIndex] == "" ? checkboxes[randIndex] = "x" : cpuChoose();
  SetStateMutation();
}
