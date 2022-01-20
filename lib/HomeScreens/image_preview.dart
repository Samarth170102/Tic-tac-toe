// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/WidgetsAndFunctions/widgets3.dart';
import 'package:flutter_application_9/main.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  String imgUrl;
  ImagePreview(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: PhotoView(
                backgroundDecoration: BoxDecoration(color: Colors.transparent),
                imageProvider: CachedNetworkImageProvider(imgUrl)),
            height: forHeight(510),
            width: width * 100,
          ),
          sizedBoxForHeight(80)
        ],
      ),
    );
  }
}
