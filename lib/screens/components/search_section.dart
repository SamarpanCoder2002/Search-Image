import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_photo/config/color_collection.dart';
import 'package:search_photo/config/text_style_collection.dart';
import 'package:search_photo/providers/main_provider.dart';
import 'package:search_photo/services/device_specific_operation.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  @override
  void initState() {
    changeSystemNavigationAndStatusBarColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.pureBlackColor.withOpacity(0.2))),
      child: TextFormField(
        cursorColor: AppColors.lightGreyColor,
        controller: Provider.of<MainProvider>(context).searchController,
        textInputAction: TextInputAction.search,
        onEditingComplete: () {
          hideKeyboard();
          Provider.of<MainProvider>(context, listen: false).onSearch();
        },
        decoration: InputDecoration(
          icon: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(Icons.search_rounded)),
          iconColor: AppColors.lightGreyColor,
          hintText: 'Search something here',
          hintStyle: TextStyleCollection.searchTextStyle
              .copyWith(color: AppColors.lightGreyColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: AppColors.transparentColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(color: AppColors.transparentColor)),
        ),
      ),
    );
  }
}
