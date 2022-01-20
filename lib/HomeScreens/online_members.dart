// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/HomeScreens/image_preview.dart';
import 'package:flutter_application_9/ScreenWrappers/online_game_page_wrapper.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class OnlineMembers extends StatefulWidget {
  UserDataModel user = UserDataModel();
  OnlineMembers(this.user);

  @override
  _OnlineMembersState createState() => _OnlineMembersState();
}

class _OnlineMembersState extends State<OnlineMembers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainDataModel>(
      stream: Database().mainDocsSnap,
      builder: (context, snapshot) {
        final user = widget.user;
        if (snapshot.hasData) {
          final main = snapshot.data;
          final onlineMembersUidList = main!.onlineMembersUidList;
          final profilePhotoUrl = main.profilePhotosMap;
          final username = main.usernamesMap;
          return onlineMembersUidList!.length != 1
              ? ListView.builder(
                  itemCount: onlineMembersUidList.length,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemBuilder: (BuildContext context, int index) {
                    String userUid = onlineMembersUidList[index];
                    return onlineMembersUidList[index] != user.uid
                        ? Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: forHeight(2),
                            child: Container(
                              height: forHeight(125),
                              width: width * 92,
                              decoration: BoxDecoration(
                                  color: Vx.hexToColor(
                                      user.accentColor.toString()),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            PageTransition(
                                                child: ImagePreview(
                                                    profilePhotoUrl![userUid]),
                                                type: PageTransitionType.scale,
                                                alignment: Alignment.center)),
                                        child: Container(
                                          height: forHeight(90),
                                          width: forHeight(90),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        profilePhotoUrl![
                                                            userUid])),
                                            color: Vx.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ).pOnly(
                                            left: forWidth(9),
                                            right: forWidth(4)),
                                      ),
                                      sizedBoxForWidth(3),
                                      Text(
                                        username![userUid],
                                        style: TextStyle(
                                            color: Vx.white,
                                            fontSize: forHeight(23),
                                            fontWeight: FontWeight.w500),
                                      ).pOnly(bottom: forHeight(2)),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      mySign = "o";
                                      Database()
                                          .dataCollection
                                          .doc(user.uid)
                                          .update({"myTurn": true});
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: OnlineGamePageWrapper(
                                                  user, userUid),
                                              type: PageTransitionType
                                                  .bottomToTop));
                                    },
                                    child: Container(
                                      height: forHeight(40),
                                      width: forHeight(80),
                                      decoration: BoxDecoration(
                                          color: Vx.white,
                                          borderRadius: BorderRadius.circular(
                                              forHeight(5))),
                                      child: Text(
                                        "Request",
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
                          ).centered().pOnly(top: forHeight(12))
                        : Container();
                  },
                )
              : Text(
                  "No other members are online",
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
