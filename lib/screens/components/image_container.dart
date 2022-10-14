import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as scheduler;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:search_photo/config/color_collection.dart';
import 'package:search_photo/config/text_style_collection.dart';
import 'package:search_photo/providers/main_provider.dart';
import 'package:search_photo/screens/show_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../services/device_specific_operation.dart';

class ImageContainerSection extends StatefulWidget {
  const ImageContainerSection({Key? key}) : super(key: key);

  @override
  State<ImageContainerSection> createState() => _ImageContainerSectionState();
}

class _ImageContainerSectionState extends State<ImageContainerSection> {
  @override
  void initState() {
    changeSystemNavigationAndStatusBarColor();
    Provider.of<MainProvider>(context, listen: false).scrollInitialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mainProvider = Provider.of<MainProvider>(context);

    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _mainProvider.isShimmerLoading
            ? _loadingView()
            : _searchResult(), // Shimmer: _loadingView
      ),
    );
  }

  _searchResult() {
    final _imagesCollection =
        Provider.of<MainProvider>(context).imagesCollection;

    if (_imagesCollection.isEmpty) {
      return Center(
        child: Text(
          'No Images Found',
          style: TextStyleCollection.headingTextStyle.copyWith(fontSize: 25),
        ),
      );
    }

    return SizedBox(
      child: MasonryGridView.count(
        controller: Provider.of<MainProvider>(context).scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 2,
        itemCount: _imagesCollection.length,
        itemBuilder: (context, index) => _imageElement(index),
      ),
    );
  }

  _imageElement(int index) {
    final _imagesCollection =
        Provider.of<MainProvider>(context).imagesCollection;

    return InkWell(
      onTap: () {
        scheduler.timeDilation = 4;

        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ShowImageScreen(
                        imageUrl: _imagesCollection[index]['src']['large'] ??
                            _imagesCollection[index]['src']['original'])))
            .then((value) {
          hideKeyboard();
          scheduler.timeDilation = 1;
        });
      },
      child: Container(
          constraints: BoxConstraints(
            maxWidth: (MediaQuery.of(context).size.width / 2) - 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.pureBlackColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: CachedNetworkImage(
              imageUrl: _imagesCollection[index]['src']['large'] ??
                  _imagesCollection[index]['src']['original'])),
    );
  }

  _loadingView() {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.pureBlackColor.withOpacity(0.6),
          highlightColor: AppColors.pureBlackColor.withOpacity(0.8),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: (MediaQuery.of(context).size.width / 2) - 10,
                minHeight: 200),
            decoration: BoxDecoration(
              color: AppColors.pureBlackColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }
}
