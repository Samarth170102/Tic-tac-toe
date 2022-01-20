// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/GameScreens/game_page_online.dart';
import 'package:flutter_application_9/GameScreens/waiting_for_accept_page.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';

String mySign = "";
String winner = "";
bool oneTimeAdd = true;

class OnlineGamePageWrapper extends StatelessWidget {
  UserDataModel userOld = UserDataModel();
  String otherUserUid = "";
  OnlineGamePageWrapper(this.userOld, this.otherUserUid);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Database().dataCollection.doc(otherUserUid).snapshots(),
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
                  List<dynamic> anotherUserRequestList =
                      anotherUser.get("requestsList");

                  if (oneTimeAdd) {
                    if (!anotherUserRequestList.contains(userUid)) {
                      print("fds");
                      oneTimeAdd = false;
                      anotherUserRequestList.add(userUid);
                      Database()
                          .dataCollection
                          .doc(anotherUserUid)
                          .update({"requestsList": anotherUserRequestList});
                      Database()
                          .dataCollection
                          .doc(userUid)
                          .update({"acceptedRequestUserUid": anotherUserUid});
                    }
                  }
                  if (user.oExit!) {
                    Navigator.pop(context);
                    Database()
                        .dataCollection
                        .doc(user.uid)
                        .update({"oExit": false});
                  }
                  bool isBothRequest =
                      user.requestsList!.contains(anotherUserUid) &&
                          anotherUserRequestList.contains(user.uid);
                  return user.acceptedRequestUserUid == anotherUserUid &&
                          anotherUser.get("acceptedRequestUserUid") ==
                              userUid &&
                          !isBothRequest
                      ? OnlineTournament(userOld, otherUserUid)
                      : WaitingForAccept(
                          user, otherUserUid, anotherUserRequestList);
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
