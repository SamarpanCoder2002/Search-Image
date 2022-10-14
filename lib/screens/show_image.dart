import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:searchphoto/config/color_collection.dart';
import 'package:searchphoto/services/device_specific_operation.dart';
import 'package:share_plus/share_plus.dart';

class ShowImageScreen extends StatefulWidget {
  final String imageUrl;

  const ShowImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {

  @override
  void dispose() {
    hideKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: InkWell(
            onDoubleTap: () =>
                Share.share("Share from Search Photo: ${widget.imageUrl}"),
            child: CachedNetworkImage(
                imageUrl: widget.imageUrl, fit: BoxFit.cover)),
      ),
    );
  }
}
