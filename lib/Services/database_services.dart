import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_9/CustomClasses/user_data_class.dart';
import 'package:flutter_application_9/Services/auth_services.dart';
import 'package:provider/provider.dart';

class Database {
  CollectionReference dataCollection =
      FirebaseFirestore.instance.collection("TestApp5");
  Future updateUserData({String? uid, String? name}) async {
    return await dataCollection.doc(uid).set({
      "uid": uid,
      "name": name,
      "username": name,
      "lastUsername": name,
      "myTurn": false,
      "wins": 0,
      "loses": 0,
      "oExit": false,
      "statsList": [],
      "checkboxes": ["", "", "", "", "", "", "", "", ""],
      "requestsList": [],
      "acceptedRequestUserUid": "",
      "email": AuthService().auth.currentUser!.email,
      "profilePhotoUrl": "https://firebasestorage.googleapis.com/"
          "v0/b/testapp4-53638.appspot.com/o/profilePhotos%2FdefaultPr"
          "ofilePhoto.png?alt=media&token=0ce0af4f-15c8-496c-aab6-46f428ac9180",
      "darkMode": false,
      "accentColor": "#4773f1",
    });
  }

  Future updateSingleDocData(
      String key, dynamic value, BuildContext context) async {
    final user = Provider.of<UserDataModel>(context, listen: false);
    return await Database().dataCollection.doc(user.uid).update({key: value});
  }

  Future updateMainDocData(String key, dynamic value) async {
    return await Database().dataCollection.doc("main").update({key: value});
  }

  UserDataModel userData(DocumentSnapshot snapshot) {
    return UserDataModel(
      uid: snapshot["uid"],
      wins: snapshot["wins"],
      name: snapshot["name"],
      loses: snapshot["loses"],
      email: snapshot["email"],
      oExit: snapshot["oExit"],
      myTurn: snapshot["myTurn"],
      username: snapshot["username"],
      darkMode: snapshot["darkMode"],
      accentColor: snapshot["accentColor"],
      lastUsername: snapshot["lastUsername"],
      profilePhotoUrl: snapshot["profilePhotoUrl"],
      statsList: List.castFrom(snapshot["statsList"]),
      checkboxes: List.castFrom(snapshot["checkboxes"]),
      requestsList: List.castFrom(snapshot["requestsList"]),
      acceptedRequestUserUid: snapshot["acceptedRequestUserUid"],
    );
  }

  Stream<UserDataModel> get docsSnap {
    return dataCollection
        .doc(AuthService().auth.currentUser!.uid)
        .snapshots()
        .map(userData);
  }

  MainDataModel mainData(DocumentSnapshot snapshot) {
    return MainDataModel(
      usernames: List.castFrom(
        snapshot["usernames"],
      ),
      onlineMembersUidList: List.castFrom(snapshot["onlineMembersUidList"]),
      emailVerificaton: Map.castFrom(snapshot["emailVerification"]),
      usernamesMap: Map.castFrom(snapshot["usernamesMap"]),
      profilePhotosMap: Map.castFrom(snapshot["profilePhotosMap"]),
    );
  }

  Stream<MainDataModel> get mainDocsSnap {
    return dataCollection.doc("main").snapshots().map(mainData);
  }
}
