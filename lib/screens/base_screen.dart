import 'package:flutter/material.dart';
import 'package:searchphoto/config/color_collection.dart';
import 'package:searchphoto/config/text_style_collection.dart';
import 'package:searchphoto/screens/components/image_container.dart';
import 'package:searchphoto/screens/components/search_section.dart';
import 'package:searchphoto/services/device_specific_operation.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  @override
  void initState() {
    changeOnlyStatusBarColor();
    changeOnlyNavigationBarColor();
    makeStatusBarTransparent(darkIcons: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: _actualBody(),
      ),
    );
  }

  _actualBody(){
    return Column(
      children: const [
        SizedBox(height: 30,),
        Center(child: Text('Search Photo', style: TextStyleCollection.headingTextStyle),),
        SizedBox(height: 15,),
        SearchSection(),
        SizedBox(height: 15,),
        ImageContainerSection()
      ],
    );
  }
}
