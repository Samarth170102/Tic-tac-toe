// ignore_for_file: must_call_super
import 'package:flutter/material.dart';
import 'package:flutter_application_9/GameScreens/game_page_two_players.dart';
import 'package:flutter_application_9/HomeScreens/online_page.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets4.dart';
import 'package:flutter_application_9/GameScreens/game_page_cpu.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets5.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = providerOfUserDataModel(context);
    final main = providerOfMainDataModel(context);
    return WillPopScope(
      onWillPop: () async {
        showExitDialog(user, context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Vx.hexToColor(user.accentColor!),
        appBar: appBarForAuth(
            toolbarHeight: 0,
            mode: true,
            specialColor: Vx.hexToColor(user.accentColor!)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: forWidth(330),
              color: Vx.hexToColor(user.accentColor!),
              child: Image.asset(
                "assets/images/logo/app_logo.png",
                color: Vx.white,
              ),
            ),
            sizedBoxForHeight(70),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  PageTransition(
                      child: GamePageCPU(user),
                      type: PageTransitionType.bottomToTop)),
              child: optionBoxForHomePage("Play"),
            ),
            sizedBoxForHeight(18),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        child: GamePage2Players(user),
                        type: PageTransitionType.bottomToTop)),
                child: optionBoxForHomePage("2 Players")),
            sizedBoxForHeight(18),
            GestureDetector(
              onTap: () async {
                bool hasConnection =
                    await InternetConnectionChecker().hasConnection;
                if (hasConnection) {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OnlinePage(user, main),
                          type: PageTransitionType.bottomToTop));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => Container(
                            height: forHeight(170),
                            width: forHeight(320),
                            decoration: BoxDecoration(
                                color: user.darkMode! ? Vx.black : Vx.white,
                                borderRadius:
                                    BorderRadius.circular(forHeight(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "No Connection",
                                      style: TextStyle(
                                          color: user.darkMode!
                                              ? Vx.white
                                              : Vx.black,
                                          fontSize: forHeight(23),
                                          fontWeight: FontWeight.w600),
                                    ).objectCenterLeft(),
                                    sizedBoxForHeight(12),
                                    Text(
                                      "You are not connected to Internet, Please"
                                      " check your Internet connection.",
                                      style: TextStyle(
                                        color: user.darkMode!
                                            ? Vx.white
                                            : Vx.black,
                                        fontSize: forHeight(15),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    "Okay ",
                                    style: TextStyle(
                                        color: Vx.hexToColor(
                                            user.accentColor.toString()),
                                        fontSize: forHeight(23),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ).pOnly(right: forWidth(5)).objectBottomRight(),
                              ],
                            ).pSymmetric(v: forHeight(14), h: forWidth(5)),
                          ).centered());
                }
              },
              child: optionBoxForHomePage("Online"),
            ),
            sizedBoxForHeight(18),
            GestureDetector(
              onTap: () => showExitDialog(user, context),
              child: optionBoxForHomePage("Quit"),
            ),
            sizedBoxForHeight(20),
          ],
        ).wFull(context),
      ),
    );
  }
}
