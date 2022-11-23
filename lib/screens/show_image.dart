import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_photo/config/color_collection.dart';
import 'package:search_photo/services/device_specific_operation.dart';
import 'package:search_photo/services/specific_services.dart';
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
      floatingActionButton: _quickAccessButtonsCollection(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CachedNetworkImage(imageUrl: widget.imageUrl),
      ),
    );
  }

  _quickAccessButtonsCollection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _shareButton(),
        const SizedBox(height: 20),
        _downloadButton(),
        const SizedBox(height: 10),
      ],
    );
  }

  _shareButton() {
    return FloatingActionButton(
      onPressed: () =>
          Share.share("Share from Search Photo:\n${widget.imageUrl}"),
      heroTag: '1',
      backgroundColor: AppColors.lightBorderGreenColor,
      child: const Icon(
        Icons.share,
        color: AppColors.pureWhiteColor,
      ),
    );
  }

  _downloadButton() {
    return FloatingActionButton(
      onPressed: () =>
          SpecificServices.downloadPicture(widget.imageUrl, context),
      heroTag: '2',
      backgroundColor: AppColors.infoMsgColor,
      child: const Icon(
        Icons.download,
        color: AppColors.pureWhiteColor,
      ),
    );
  }
}
