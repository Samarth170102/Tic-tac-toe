// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/game_logic.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets2.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:velocity_x/velocity_x.dart';

class GamePageCPU extends StatefulWidget {
  UserDataModel user = UserDataModel();
  GamePageCPU(this.user);
  @override
  _GamePageCPUState createState() => _GamePageCPUState();
}

beforeExitGameCPU() {
  checkboxes = ["", "", "", "", "", "", "", "", ""];
  isWin = false;
  isUserTurn = true;
}

class _GamePageCPUState extends State<GamePageCPU> {
  bool isEasy = true;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    VxState.watch(context, on: [SetStateMutation]);
    return WillPopScope(
      onWillPop: () async {
        isEasy = true;
        checkboxes = ["", "", "", "", "", "", "", "", ""];
        isWin = false;
        isUserTurn = true;
        return true;
      },
      child: Scaffold(
        backgroundColor: user.darkMode! ? Vx.black : Vx.white,
        appBar: appBarForAuth(toolbarHeight: 0, mode: user.darkMode),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rowforHeadingInEditProfile("Play with CPU", user.darkMode!, context,
                function: beforeExitGameCPU),
            sizedBoxForHeight(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "  Difficulty: ",
                      style: TextStyle(
                          fontSize: forHeight(19),
                          color: user.darkMode! ? Vx.white : Vx.black),
                    ),
                    sizedBoxForWidth(15),
                    GestureDetector(
                      onTap: () {
                        if (isEasy == false) {
                          isEasy = true;
                          checkboxes = ["", "", "", "", "", "", "", "", ""];
                          isWin = false;
                          isUserTurn = true;
                          setState(() {});
                        }
                      },
                      child: Text(
                        "Easy",
                        style: TextStyle(
                            fontSize: forHeight(21),
                            color: isEasy
                                ? Vx.hexToColor(user.accentColor!)
                                : user.darkMode!
                                    ? Vx.white
                                    : Vx.gray400,
                            fontWeight: isEasy ? FontWeight.w500 : null),
                      ),
                    ),
                    sizedBoxForWidth(30),
                    GestureDetector(
                      onTap: () {
                        if (isEasy == true) {
                          isEasy = false;
                          checkboxes = ["", "", "", "", "", "", "", "", ""];
                          isWin = false;
                          isUserTurn = true;
                          setState(() {});
                        }
                      },
                      child: Text(
                        "Hard",
                        style: TextStyle(
                            fontSize: forHeight(21),
                            color: isEasy
                                ? user.darkMode!
                                    ? Vx.white
                                    : Vx.gray400
                                : Vx.hexToColor(user.accentColor!),
                            fontWeight: !isEasy ? FontWeight.w500 : null),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    checkboxes = ["", "", "", "", "", "", "", "", ""];
                    isWin = false;
                    isUserTurn = true;
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
                            ).pOnly(bottom: forHeight(7), right: forWidth(11))
                          : Container(
                              height: forHeight(42),
                              width: forWidth(1),
                            ),
                )
              ],
            ),
            sizedBoxForHeight(140),
            Stack(
              children: [
                Container(
                    height: forHeight(330),
                    child: Image.asset(
                      "assets/images/game/tic_tac_toe_border.png",
                      color: user.darkMode! ? Vx.white : Vx.gray400,
                    )),
                positionedBoxForGameCPU(0, isEasy, 0, 0, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(1, isEasy, 0, 112, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(2, isEasy, -1, 220, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(3, isEasy, 111, -1, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(4, isEasy, 111.5, 111, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(5, isEasy, 111, 221, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(6, isEasy, 222, 0, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(7, isEasy, 222, 111.5, user.darkMode!,
                    user.accentColor!, context),
                positionedBoxForGameCPU(8, isEasy, 222, 222, user.darkMode!,
                    user.accentColor!, context),
              ],
            )
          ],
        ).wFull(context),
      ),
    );
  }
}

Positioned positionedBoxForGameCPU(int index, bool isEasy, double top,
    double left, bool darkMode, String accentColor, BuildContext context) {
  bool isCross = checkboxes[index] == "x";
  return Positioned(
    top: forHeight(top),
    left: forHeight(left),
    child: GestureDetector(
      onTap: () async {
        if (isUserTurn) {
          if (!isWin) {
            if (checkboxes[index] == "") {
              isUserTurn = false;
              checkboxes[index] = "o";
              checkWinForCPU(accentColor, context);
              SetStateMutation();
              if (!isWin) {
                if (checkboxes.contains("")) {
                  await Future.delayed(Duration(seconds: 1), () {
                    if (isEasy) {
                      cpuChoose();
                      checkWinForCPU(accentColor, context);
                      isUserTurn = true;
                    } else {
                      crossForHard();
                      checkWinForCPU(accentColor, context);
                      isUserTurn = true;
                    }
                  });
                }
              }
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
