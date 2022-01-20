// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/HomeScreens/online_members.dart';
import 'package:flutter_application_9/HomeScreens/requests_page.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:velocity_x/velocity_x.dart';

class OnlinePage extends StatefulWidget {
  UserDataModel user = UserDataModel();
  MainDataModel main = MainDataModel();
  OnlinePage(this.user, this.main);
  @override
  _OnlinePageState createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> with WidgetsBindingObserver {
  @override
  void initState() {  
    super.initState();
    final main = widget.main;
    final onlineMembersUidList = main.onlineMembersUidList;
    if (!onlineMembersUidList!.contains(widget.user.uid)) {
      onlineMembersUidList.add(widget.user.uid);
      Database()
          .updateMainDocData("onlineMembersUidList", onlineMembersUidList);
    }
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    final onlineMembersUidList = widget.main.onlineMembersUidList;
    if (state == AppLifecycleState.resumed) {
      onlineMembersUidList!.add(widget.user.uid);
    } else {
      onlineMembersUidList!.remove(widget.user.uid);
    }
    Database().updateMainDocData("onlineMembersUidList", onlineMembersUidList);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainDataModel>(
      stream: Database().mainDocsSnap,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final user = widget.user;
          final main = snapshot.data;
          final onlineMembersUidList = main.onlineMembersUidList;
          Future removeUserUidFromList() async {
            onlineMembersUidList.remove(user.uid);
            await Database().updateMainDocData(
                "onlineMembersUidList", onlineMembersUidList);
          }

          return WillPopScope(
            onWillPop: () async {
              await removeUserUidFromList();
              return true;
            },
            child: Scaffold(
                backgroundColor: user.darkMode! ? Vx.black : Vx.white,
                appBar: appBarForAuth(toolbarHeight: 0, mode: user.darkMode),
                body: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Row(children: [
                        GestureDetector(
                            onTap: () async {
                              await removeUserUidFromList();
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 5.72921 * height,
                                width: 5.72921 * height,
                                child: Align(
                                  child: Image.asset(
                                    "assets/images/bottombar/back.png",
                                    color: user.darkMode! ? Vx.white : Vx.black,
                                  ).pSymmetric(h: 1.6082 * height),
                                ))),
                        Container(
                          child: Text(
                            "Play Online",
                            style: TextStyle(
                                color: user.darkMode! ? Vx.white : Vx.black,
                                fontSize: 2.61332 * height,
                                fontWeight: FontWeight.w500),
                          ),
                        ).pOnly(bottom: 0.20102 * height),
                      ]),
                      Container(
                        height: forHeight(55),
                        width: width * 100,
                        child: TabBar(
                          tabs: [
                            Text("Online "),
                            Text(" Requests"),
                          ],
                          indicatorWeight: 3,
                          indicatorColor: Vx.hexToColor(user.accentColor!),
                          labelColor: Vx.hexToColor(user.accentColor!),
                          labelStyle: TextStyle(
                              fontSize: forHeight(18),
                              fontWeight: FontWeight.w500),
                          unselectedLabelColor:
                              user.darkMode! ? Vx.white : Vx.gray500,
                          unselectedLabelStyle:
                              TextStyle(fontSize: forHeight(18)),
                        ),
                      ),
                      Container(
                        width: width * 100,
                        child: TabBarView(children: [
                          OnlineMembers(user),
                          Requests(
                            user,
                          )
                        ]),
                      ).expand()
                    ],
                  ),
                )),
          );
        } else {
          return loadingWidget(
              accentColor: widget.user.accentColor, mode: widget.user.darkMode);
        }
      },
    );
  }
}
