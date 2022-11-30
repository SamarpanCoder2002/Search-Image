import 'package:flutter/material.dart';

import '../../config/color_collection.dart';
import '../../config/text_style_collection.dart';

commonTextButton(
    {required String btnText,
    required VoidCallback onPressed,
    double? fontSize,
    Color? borderColor,
    Color? textColor}) {
  return TextButton(
    style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: borderColor ?? AppColors.darkBorderGreenColor))),
    child: Text(
      btnText,
      style: TextStyleCollection.terminalTextStyle.copyWith(
          color: textColor ?? AppColors.darkBorderGreenColor,
          fontSize: fontSize ?? 12),
    ),
    onPressed: onPressed,
  );
}
