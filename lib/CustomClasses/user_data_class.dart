class UserDataModel {
  int? wins;
  int? loses;
  String? uid;
  bool? oExit;
  bool? myTurn;
  String? name;
  String? email;
  bool? darkMode;
  String? username;
  String? accentColor;
  String? lastUsername;
  String? profilePhotoUrl;
  List<dynamic>? statsList;
  List<dynamic>? checkboxes;
  List<dynamic>? requestsList;
  String? acceptedRequestUserUid;
  UserDataModel({
    this.uid,
    this.oExit,
    this.wins,
    this.name,
    this.loses,
    this.email,
    this.myTurn,
    this.username,
    this.darkMode,
    this.statsList,
    this.checkboxes,
    this.accentColor,
    this.lastUsername,
    this.requestsList,
    this.profilePhotoUrl,
    this.acceptedRequestUserUid,
  });
}

class MainDataModel {
  List<dynamic>? usernames;
  List<dynamic>? onlineMembersUidList;
  Map<String, dynamic>? usernamesMap;
  Map<String, dynamic>? profilePhotosMap;
  Map<String, dynamic>? emailVerificaton;
  MainDataModel({
    this.usernames,
    this.usernamesMap,
    this.emailVerificaton,
    this.profilePhotosMap,
    this.onlineMembersUidList,
  });
}
