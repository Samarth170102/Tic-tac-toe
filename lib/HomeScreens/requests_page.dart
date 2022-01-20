// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/GameScreens/game_page_online.dart';
import 'package:flutter_application_9/HomeScreens/image_preview.dart';
import 'package:flutter_application_9/ScreenWrappers/online_game_page_wrapper.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class Requests extends StatefulWidget {
  UserDataModel user = UserDataModel();
  Requests(this.user);
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    final main = providerOfMainDataModel(context);
    return StreamBuilder<UserDataModel>(
      stream: Database().docsSnap,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (snapshot.hasData) {
          return user!.requestsList!.isNotEmpty
              ? ListView.builder(
                  itemCount: user.requestsList!.length,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemBuilder: (BuildContext context, int index) {
                    String anotherUserUid = user.requestsList![index];
                    return Material(
                      borderRadius: BorderRadius.circular(8),
                      elevation: forHeight(2),
                      child: Container(
                        height: forHeight(125),
                        width: width * 92,
                        decoration: BoxDecoration(
                            color: Vx.hexToColor(user.accentColor.toString()),
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
                                          child: ImagePreview(
                                              main.profilePhotosMap![
                                                  anotherUserUid]),
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
                                                  anotherUserUid])),
                                      color: Vx.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ).pOnly(
                                      left: forWidth(9), right: forWidth(4)),
                                ),
                                sizedBoxForWidth(3),
                                Text(
                                  main.usernamesMap![anotherUserUid],
                                  style: TextStyle(
                                      color: Vx.white,
                                      fontSize: forHeight(23),
                                      fontWeight: FontWeight.w500),
                                ).pOnly(bottom: forHeight(2)),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                mySign = "x";
                                Database().dataCollection.doc(user.uid).update({
                                  "acceptedRequestUserUid": anotherUserUid,
                                  "myTurn": false
                                });
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: OnlineTournament(
                                            user, anotherUserUid),
                                        type: PageTransitionType.bottomToTop));
                              },
                              child: Container(
                                height: forHeight(40),
                                width: forHeight(80),
                                decoration: BoxDecoration(
                                    color: Vx.white,
                                    borderRadius:
                                        BorderRadius.circular(forHeight(5))),
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontSize: forHeight(16),
                                      color: Vx.hexToColor(
                                          user.accentColor.toString()),
                                      fontWeight: FontWeight.w500),
                                ).centered(),
                              ).pOnly(right: forWidth(12)),
                            ),
                          ],
                        ),
                      ),
                    ).centered().pOnly(
                        bottom: forHeight(12),
                        top: index == 0 ? forHeight(12) : 0);
                  },
                )
              : Text(
                  "No requests from other users",
                  style: TextStyle(
                      color: user.darkMode! ? Vx.white : Vx.black,
                      fontSize: forHeight(21)),
                ).centered().pOnly(bottom: forHeight(55));
        } else {
          return loadingWidget(
              accentColor: widget.user.accentColor, mode: widget.user.darkMode);
        }
      },
    );
  }
}
