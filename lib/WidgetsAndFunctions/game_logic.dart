import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/GameScreens/game_page_cpu.dart';
import 'package:flutter_application_9/ScreenWrappers/online_game_page_wrapper.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

void checkWinForCPU(String accentColor, BuildContext context) {
  if (checkConditionsForWin(0, 1, 2)) {
    showWinToastCPU(0, accentColor, context);
  } else if (checkConditionsForWin(3, 4, 5)) {
    showWinToastCPU(3, accentColor, context);
  } else if (checkConditionsForWin(6, 7, 8)) {
    showWinToastCPU(6, accentColor, context);
  } else if (checkConditionsForWin(0, 3, 6)) {
    showWinToastCPU(6, accentColor, context);
  } else if (checkConditionsForWin(1, 4, 7)) {
    showWinToastCPU(1, accentColor, context);
  } else if (checkConditionsForWin(2, 5, 8)) {
    showWinToastCPU(2, accentColor, context);
  } else if (checkConditionsForWin(0, 4, 8)) {
    showWinToastCPU(0, accentColor, context);
  } else if (checkConditionsForWin(2, 4, 6)) {
    showWinToastCPU(2, accentColor, context);
  } else if (!checkboxes.contains("") && !isWin) {
    VxToast.show(context,
        msg: "Tie!",
        bgColor: Vx.hexToColor(accentColor),
        textColor: Vx.white,
        textSize: forHeight(20));
    isWin = true;
  }
}

void checkWinFor2Players(String accentColor, BuildContext context) {
  if (checkConditionsForWin(0, 1, 2)) {
    showWinToast2Players(0, accentColor, context);
  } else if (checkConditionsForWin(3, 4, 5)) {
    showWinToast2Players(3, accentColor, context);
  } else if (checkConditionsForWin(6, 7, 8)) {
    showWinToast2Players(6, accentColor, context);
  } else if (checkConditionsForWin(0, 3, 6)) {
    showWinToast2Players(6, accentColor, context);
  } else if (checkConditionsForWin(1, 4, 7)) {
    showWinToast2Players(1, accentColor, context);
  } else if (checkConditionsForWin(2, 5, 8)) {
    showWinToast2Players(2, accentColor, context);
  } else if (checkConditionsForWin(0, 4, 8)) {
    showWinToast2Players(0, accentColor, context);
  } else if (checkConditionsForWin(2, 4, 6)) {
    showWinToast2Players(2, accentColor, context);
  } else if (!checkboxes.contains("") && !isWin) {
    VxToast.show(context,
        msg: "Tie!",
        bgColor: Vx.hexToColor(accentColor),
        textColor: Vx.white,
        textSize: forHeight(20));
    isWin = true;
  }
}

void checkWinForTournament(List<dynamic> myCheckboxes, String accentColor,
    UserDataModel user, DocumentSnapshot otherUser) {
  if (checkConditionsForWinTournament(myCheckboxes, 0, 1, 2)) {
    showWinTournament(0, myCheckboxes, user, otherUser);
  } else if (checkConditionsForWinTournament(myCheckboxes, 3, 4, 5)) {
    showWinTournament(3, myCheckboxes, user, otherUser);
  } else if (checkConditionsForWinTournament(myCheckboxes, 6, 7, 8)) {
    showWinTournament(6, myCheckboxes, user, otherUser);
  } else if (checkConditionsForWinTournament(myCheckboxes, 0, 3, 6)) {
    showWinTournament(6, myCheckboxes, user, otherUser);
  } else if (checkConditionsForWinTournament(myCheckboxes, 1, 4, 7)) {
    showWinTournament(1, myCheckboxes, user, otherUser);
  } else if (checkConditionsForWinTournament(myCheckboxes, 2, 5, 8)) {
    showWinTournament(2, myCheckboxes, user, otherUser);
  } else if (checkConditionsForWinTournament(myCheckboxes, 0, 4, 8)) {
    showWinTournament(0, myCheckboxes, user, otherUser);
  } else if (checkConditionsForWinTournament(myCheckboxes, 2, 4, 6)) {
    showWinTournament(2, myCheckboxes, user, otherUser);
  } else if (!checkboxes.contains("") && !isWin) {
    isWin = true;
  }
}

checkConditionsForWin(int index1, int index2, int index3) {
  return checkboxes[index1] == checkboxes[index2] &&
      checkboxes[index2] == checkboxes[index3] &&
      checkboxes[index1] != "" &&
      checkboxes[index2] != "" &&
      checkboxes[index3] != "";
}

checkConditionsForWinTournament(
    List<dynamic> myCheckboxes, int index1, int index2, int index3) {
  return myCheckboxes[index1] == myCheckboxes[index2] &&
      myCheckboxes[index2] == myCheckboxes[index3] &&
      myCheckboxes[index1] != "" &&
      myCheckboxes[index2] != "" &&
      myCheckboxes[index3] != "";
}

checkConditionForHard(int index1, int index2, int index3) {
  return checkboxes[index1] == "o" &&
      checkboxes[index2] == "o" &&
      checkboxes[index3] == "";
}

showWinTournament(int index, List<dynamic> myCheckboxes, UserDataModel user,
    DocumentSnapshot otherUser) {
  String username = user.username.toString();
  String anotherUsername = otherUser.get("username");
  int wins = 0;
  int loses = 0;
  List<dynamic> userStatsList = user.statsList!;
  List<dynamic> otherUserStatsList = otherUser.get("statsList");
  String date = ("${DateFormat('dd').format(DateTime.now())} "
      "${months[int.parse(DateFormat('MM').format(DateTime.now()).toString())]} "
      "${DateFormat('yyy').format(DateTime.now())}");
  if (myCheckboxes[index] == mySign) {
    isWin = true;
    wins = user.wins! + 1;
    loses = otherUser.get("loses") + 1;
    userStatsList
        .add({"uid": otherUser.get("uid"), "result": "Won", "date": date});
    otherUserStatsList.add({"uid": user.uid, "result": "Lose", "date": date});
    winner = "$username Won!";
    Database()
        .dataCollection
        .doc(user.uid)
        .update({"wins": wins, "statsList": userStatsList});
    Database()
        .dataCollection
        .doc(otherUser.get("uid"))
        .update({"loses": loses, "statsList": otherUserStatsList});
  } else {
    isWin = true;
    winner = "$anotherUsername Won!";
  }
  SetStateMutation();
}

showWinToastCPU(int index, String accentColor, BuildContext context) {
  checkboxes[index] == "o"
      ? VxToast.show(context,
          msg: "You won!",
          bgColor: Vx.hexToColor(accentColor),
          textColor: Vx.white,
          textSize: forHeight(18))
      : VxToast.show(context,
          msg: "Cpu won",
          bgColor: Vx.hexToColor(accentColor),
          textColor: Vx.white,
          textSize: forHeight(18));
  isWin = true;
}

showWinToast2Players(int index, String accentColor, BuildContext context) {
  checkboxes[index] == "o"
      ? VxToast.show(context,
          msg: "Player 1 won!",
          bgColor: Vx.hexToColor(accentColor),
          textColor: Vx.white,
          textSize: forHeight(18))
      : VxToast.show(context,
          msg: "Player 2 won!",
          bgColor: Vx.hexToColor(accentColor),
          textColor: Vx.white,
          textSize: forHeight(18));
  isWin = true;
}

crossForHard() {
  if (checkConditionForHard(0, 1, 2)) {
    checkboxes[2] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(0, 3, 6)) {
    checkboxes[6] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(0, 4, 8)) {
    checkboxes[8] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(0, 2, 1)) {
    checkboxes[1] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(0, 6, 3)) {
    checkboxes[3] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(0, 8, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(1, 4, 7)) {
    checkboxes[7] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(1, 7, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(2, 1, 0)) {
    checkboxes[0] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(2, 5, 8)) {
    checkboxes[8] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(2, 4, 6)) {
    checkboxes[6] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(2, 0, 1)) {
    checkboxes[1] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(2, 8, 5)) {
    checkboxes[5] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(2, 6, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(3, 4, 5)) {
    checkboxes[5] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(3, 5, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(5, 4, 3)) {
    checkboxes[3] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(5, 3, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(6, 3, 0)) {
    checkboxes[0] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(6, 7, 8)) {
    checkboxes[8] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(6, 4, 2)) {
    checkboxes[2] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(6, 0, 3)) {
    checkboxes[3] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(6, 8, 7)) {
    checkboxes[7] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(6, 2, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(7, 4, 1)) {
    checkboxes[1] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(7, 1, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(8, 5, 2)) {
    checkboxes[2] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(8, 7, 6)) {
    checkboxes[6] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(8, 4, 0)) {
    checkboxes[0] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(8, 2, 5)) {
    checkboxes[5] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(8, 6, 7)) {
    checkboxes[7] = "x";
    SetStateMutation();
  } else if (checkConditionForHard(8, 0, 4)) {
    checkboxes[4] = "x";
    SetStateMutation();
  } else {
    cpuChoose();
  }
}
