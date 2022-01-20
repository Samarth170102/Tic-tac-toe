// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/ScreenWrappers/online_game_page_wrapper.dart';
import 'package:flutter_application_9/Services/database_services.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets2.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets5.dart';
import 'package:velocity_x/velocity_x.dart';

class WaitingForAccept extends StatefulWidget {
  UserDataModel user = UserDataModel();
  String anotherUserUid = "";
  List<dynamic> anotherUserRequestList = [];
  WaitingForAccept(this.user, this.anotherUserUid, this.anotherUserRequestList);
  @override
  _WaitingForAcceptState createState() => _WaitingForAcceptState();
}

class _WaitingForAcceptState extends State<WaitingForAccept> {
  bool requestCancle = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          requestCancle = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    Future goBackToOnlinePage() async {
      await Database()
          .dataCollection
          .doc(user.uid)
          .update({"acceptedRequestUserUid": ""});
      widget.anotherUserRequestList.remove(user.uid);
      await Database()
          .dataCollection
          .doc(widget.anotherUserUid)
          .update({"requestsList": widget.anotherUserRequestList});
      oneTimeAdd = true;
    }

    return WillPopScope(
      onWillPop: () async {
        showCancelRequestDialog(user, widget.anotherUserUid,
            widget.anotherUserRequestList, context);
        return false;
      },
      child: Scaffold(
        backgroundColor: user.darkMode! ? Vx.black : Vx.white,
        appBar: appBarForAuth(toolbarHeight: 0, mode: user.darkMode),
        body: Column(
          children: [
            rowforHeadingInEditProfile("Waiting Page", user.darkMode!, context,
                function: goBackToOnlinePage),  
            sizedBoxForHeight(270),
            Text(
              "Please wait until the other user accept your request",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: forHeight(25),
                  color: user.darkMode! ? Vx.white : Vx.black),
            ),
            sizedBoxForHeight(290),
            Visibility(
              visible: requestCancle,
              child: GestureDetector(
                onTap: () => showCancelRequestDialog(
                    user,
                    widget.anotherUserUid,
                    widget.anotherUserRequestList,
                    context),
                child: Text("Cancel request",
                    style: TextStyle(
                        fontSize: forHeight(23),
                        color: Vx.hexToColor(user.accentColor.toString()))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
