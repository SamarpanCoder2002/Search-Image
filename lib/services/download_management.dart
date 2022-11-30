import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:search_photo/config/color_collection.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../config/data_collection.dart';
import '../config/text_style_collection.dart';
import '../screens/components/common_button.dart';
import 'debugging.dart';

updateApp(context) async {
  _onAppUpdate() {
    try {
      launchUrlString(TextCollection.appLink,
          mode: LaunchMode.externalApplication);
    } catch (e) {
      debugShow('Error in Opening: $e');
    }
  }

  try {
    final newVersion = NewVersionPlus();

    final status = await newVersion.getVersionStatus();
    if (status == null) return;

    debugShow(status.releaseNotes);
    debugShow(status.appStoreLink);
    debugShow(status.localVersion);
    debugShow(status.storeVersion);
    debugShow(status.canUpdate.toString());

    if (!status.canUpdate) return;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              backgroundColor: AppColors.pureWhiteColor,
              title: Text(
                'Update This app',
                style: TextStyleCollection.secondaryHeadingTextStyle
                    .copyWith(fontSize: 18, color: AppColors.pureBlackColor),
              ),
              content: Text(
                'Please update this app immediately to enjoy better performances with major bugs fix',
                style: TextStyleCollection.secondaryHeadingTextStyle.copyWith(
                    fontSize: 16,
                    color: AppColors.pureBlackColor,
                    fontWeight: FontWeight.normal),
              ),
              actions: [
                commonTextButton(
                    btnText: "Maybe Later",
                    onPressed: () => Navigator.pop(context),
                    borderColor: AppColors.pureWhiteColor,
                    textColor: AppColors.darkInactiveIconColor),
                const SizedBox(width: 5),
                commonTextButton(
                    btnText: "Update Now",
                    onPressed: _onAppUpdate,
                    borderColor: AppColors.pureWhiteColor,
                    fontSize: 16,
                    textColor: AppColors.myMsgLightModeColor),
              ],
            ));
  } catch (e) {
    debugShow('Error in update: $e');
  }
}
