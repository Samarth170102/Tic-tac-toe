// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/HomeScreens/image_preview.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets2.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class Statistics extends StatefulWidget {
  UserDataModel user = UserDataModel();
  Statistics(this.user);
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final main = providerOfMainDataModel(context);
    final statsList = user.statsList;
    double wins = user.wins!.toDouble();
    double loses = user.loses!.toDouble();
    double winPer = 0;
    if (wins == 0 && loses == 0) {
      winPer = 0;
    } else {
      winPer = wins / (wins + loses);
    }
    return Scaffold(
        backgroundColor: user.darkMode! ? Vx.black : Vx.white,
        appBar: appBarForAuth(toolbarHeight: 0, mode: user.darkMode),
        body: ListView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            rowforHeadingInEditProfile("Statistics", user.darkMode!, context),
            sizedBoxForHeight(2),
            Text(
              "Wins/Loses - Online",
              style: TextStyle(
                color: user.darkMode! ? Vx.white : Vx.black,
                fontSize: forHeight(26),
                fontWeight: FontWeight.w600,
              ),
            ).objectCenterLeft().pOnly(left: forWidth(11)),
            sizedBoxForHeight(35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: forHeight(30),
                      width: width * 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Text(
                            "Wins ${user.wins} ",
                            style: TextStyle(
                                color: user.darkMode! ? Vx.white : Vx.black,
                                fontSize: forHeight(26),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxForHeight(10),
                    Container(
                      height: forHeight(30),
                      width: width * 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Text(
                            "Loses ${user.loses} ",
                            style: TextStyle(
                                color: user.darkMode! ? Vx.white : Vx.black,
                                fontSize: forHeight(26),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Material(
                    borderRadius: BorderRadius.circular(forHeight(10)),
                    elevation: forHeight(3),
                    child: Container(
                      height: forHeight(150),
                      width: forHeight(200),
                      decoration: BoxDecoration(
                          color: Vx.hexToColor(user.accentColor.toString()),
                          borderRadius: BorderRadius.circular(forHeight(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Win %",
                            style: TextStyle(
                                color: Vx.white,
                                fontSize: forHeight(33),
                                fontWeight: FontWeight.w500),
                          ),
                          CircularPercentIndicator(
                            radius: forHeight(
                              80,
                            ),
                            center: Text(
                              "${(winPer * 100).toInt()}",
                              style: TextStyle(
                                  fontSize: forHeight(23), color: Vx.white),
                            ),
                            animation: true,
                            animationDuration: 1000,
                            percent: winPer.toDouble(),
                            lineWidth: forWidth(8),
                            backgroundColor:
                                Vx.hexToColor(user.accentColor.toString()),
                            progressColor: Vx.white,
                          ),
                          sizedBoxForHeight(2),
                        ],
                      ).pSymmetric(v: forHeight(7)),
                    )).pOnly(right: forWidth(8)),
              ],
            ).pSymmetric(h: forWidth(11)),
            sizedBoxForHeight(26),
            Text(
              "Past Tornaments",
              style: TextStyle(
                color: user.darkMode! ? Vx.white : Vx.black,
                fontSize: forHeight(26),
                fontWeight: FontWeight.w600,
              ),
            ).objectCenterLeft().pOnly(left: forWidth(11)),
            sizedBoxForHeight(10),
            statsList!.isNotEmpty
                ? Container(
                    width: width * 100,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: statsList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        int main_index = statsList.length - index - 1;
                        String date = statsList[main_index]["date"];
                        String userUid = statsList[main_index]["uid"];
                        String result = statsList[main_index]["result"];
                        return Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: forHeight(2.5),
                          child: Container(
                            height: forHeight(125),
                            width: width * 92,
                            decoration: BoxDecoration(
                                color:
                                    Vx.hexToColor(user.accentColor.toString()),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          PageTransition(
                                              child: ImagePreview(main
                                                  .profilePhotosMap![userUid]),
                                              type: PageTransitionType.scale,
                                              alignment: Alignment.center)),
                                      child: Container(
                                        height: forHeight(90),
                                        width: forHeight(90),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  main.profilePhotosMap![
                                                      userUid])),
                                          color: Vx.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ).pOnly(
                                          left: forWidth(9),
                                          right: forWidth(4)),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          main.usernamesMap![userUid],
                                          style: TextStyle(
                                              color: Vx.white,
                                              fontSize: forHeight(23),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        sizedBoxForHeight(16),
                                        Text(
                                          date,
                                          style: TextStyle(
                                              fontSize: forHeight(16),
                                              color: Vx.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        sizedBoxForHeight(2),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "You $result",
                                  style: TextStyle(
                                      fontSize: forHeight(18),
                                      color: Vx.white,
                                      fontWeight: FontWeight.w500),
                                ).pOnly(right: forWidth(10))
                              ],
                            ),
                          ),
                        ).centered().pOnly(bottom: forHeight(10));
                      },
                    ),
                  )
                : Container(
                    height: forHeight(400),
                    child: Text(
                      "No Record Found",
                      style:
                          TextStyle(color: Vx.white, fontSize: forHeight(30)),
                    ).centered(),
                  )
          ],
        ));
  }
}
