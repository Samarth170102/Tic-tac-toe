import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/HomePageSelector/homepage_selector.dart';
import 'package:flutter_application_9/HomeScreens/image_preview.dart';
import 'package:flutter_application_9/Services/auth_services.dart';
import 'package:flutter_application_9/UserProfilePages/about_us.dart';
import 'package:flutter_application_9/UserProfilePages/clear_cache.dart';
import 'package:flutter_application_9/UserProfilePages/edit_profile.dart';
import 'package:flutter_application_9/UserProfilePages/statistics.dart';
import 'package:flutter_application_9/UserProfilePages/theme.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets1.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets2.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = providerOfUserDataModel(context);
    final userIni = providerOfUserAuthData(context);
    String creationTime = userIni!.creationTime.split(" ")[0];
    String lastSignInTime = userIni.lastSignInTime.split(" ")[0];
    return Scaffold(
      backgroundColor: Vx.hexToColor(user.accentColor!),
      appBar: appBarForAuth(
          toolbarHeight: 0,
          mode: true,
          specialColor: Vx.hexToColor(user.accentColor!)),
      body: Column(
        children: [
          Text(
            "My Profile",
            style: TextStyle(
              fontSize: forHeight(28),
              color: Vx.white,
              fontWeight: FontWeight.w500,
            ),
          ).objectCenterLeft().pSymmetric(v: forHeight(5)),
          sizedBoxForHeight(22),
          Material(
            borderRadius: BorderRadius.circular(forHeight(8)),
            elevation: forHeight(3),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  PageTransition(
                      child: EditProfile(creationTime, lastSignInTime),
                      type: PageTransitionType.bottomToTop)),
              child: Container(
                height: forHeight(200),
                width: width * 96,
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius: BorderRadius.circular(forHeight(8))),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          PageTransition(
                              child:
                                  ImagePreview(user.profilePhotoUrl.toString()),
                              type: PageTransitionType.scale,
                              alignment: Alignment.center)),
                      child: Container(
                        height: forHeight(140),
                        width: forHeight(140),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    user.profilePhotoUrl.toString()))),
                      ).pOnly(left: forWidth(12)),
                    ),
                    sizedBoxForWidth(11),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.username.toString(),
                          style: TextStyle(
                              fontSize: forHeight(26),
                              fontWeight: FontWeight.w500),
                        ),
                        sizedBoxForHeight(25),
                        Text(
                          user.name.toString(),
                          style: TextStyle(
                            fontSize: forHeight(20),
                          ),
                        ),
                        sizedBoxForHeight(11)
                      ],
                    ).w(width * 53)
                  ],
                ),
              ),
            ),
          ),
          sizedBoxForHeight(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        child: Statistics(user),
                        type: PageTransitionType.bottomToTop)),
                child: containerForUserProfile("Statistics"),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        child: modalBottomSheetForClearCache(context),
                        type: PageTransitionType.bottomToTop)),
                child: containerForUserProfile("Cache"),
              ),
            ],
          ),
          sizedBoxForHeight(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => modalBottomSheetForTheme(user.darkMode!, context),
                child: containerForUserProfile("Theme"),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        child: AboutUs(),
                        type: PageTransitionType.bottomToTop)),
                child: containerForUserProfile("About Us"),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              indexOfPage = 0;
              AuthService().signOut();
            },
            child: Material(
              elevation: forHeight(2.5),
              borderRadius: BorderRadius.circular(forHeight(6)),
              child: Container(
                height: forHeight(70),
                width: forWidth(150),
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                      fontSize: forHeight(25), fontWeight: FontWeight.w500),
                ).centered(),
                decoration: BoxDecoration(
                    color: Vx.white,
                    borderRadius: BorderRadius.circular(forHeight(6))),
              ),
            ),
          ),
          sizedBoxForHeight(58),
        ],
      ).wFull(context).pSymmetric(h: forHeight(8)),
    );
  }
}
