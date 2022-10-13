import 'package:flutter/material.dart';
import 'package:searchphoto/config/color_collection.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.pureBlackColor.withOpacity(0.2))
      ),
      child: TextFormField(
        cursorColor: AppColors.lightGreyColor,
        onEditingComplete: (){

        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: AppColors.pureBlackColor.withOpacity(0.2))
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: AppColors.pureBlackColor.withOpacity(0.2))
          ),
        ),
      ),
    );
  }
}
