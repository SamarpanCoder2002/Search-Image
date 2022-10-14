import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_photo/config/color_collection.dart';
import 'package:search_photo/config/text_style_collection.dart';
import 'package:search_photo/providers/main_provider.dart';
import 'package:search_photo/screens/components/image_container.dart';
import 'package:search_photo/screens/components/search_section.dart';
import 'package:search_photo/services/device_specific_operation.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    changeSystemNavigationAndStatusBarColor();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<MainProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
        child: _actualBody(),
      ),
    );
  }

  _actualBody() {
    return Column(
      children: const [
        SizedBox(
          height: 30,
        ),
        Center(
          child:
              Text('Search Photo', style: TextStyleCollection.headingTextStyle),
        ),
        SizedBox(
          height: 15,
        ),
        SearchSection(),
        SizedBox(
          height: 15,
        ),
        ImageContainerSection()
      ],
    );
  }
}
