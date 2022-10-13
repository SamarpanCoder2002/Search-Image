import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:searchphoto/config/color_collection.dart';
import 'package:shimmer/shimmer.dart';

class ImageContainerSection extends StatefulWidget {
  const ImageContainerSection({Key? key}) : super(key: key);

  @override
  State<ImageContainerSection> createState() => _ImageContainerSectionState();
}

class _ImageContainerSectionState extends State<ImageContainerSection> {
  final _sampleImagesCollection = [
    "https://images.pexels.com/photos/1024960/pexels-photo-1024960.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/258421/pexels-photo-258421.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/369433/pexels-photo-369433.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/773124/pexels-photo-773124.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/984944/pexels-photo-984944.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/3693901/pexels-photo-3693901.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1187079/pexels-photo-1187079.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1024960/pexels-photo-1024960.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/258421/pexels-photo-258421.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/369433/pexels-photo-369433.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/773124/pexels-photo-773124.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/984944/pexels-photo-984944.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/3693901/pexels-photo-3693901.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1187079/pexels-photo-1187079.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1024960/pexels-photo-1024960.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/258421/pexels-photo-258421.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/369433/pexels-photo-369433.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/773124/pexels-photo-773124.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/984944/pexels-photo-984944.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/3693901/pexels-photo-3693901.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/1187079/pexels-photo-1187079.jpeg?auto=compress&cs=tinysrgb&w=600",
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: _searchResult(), // Shimmer: _loadingView
      ),
    );
  }

  _searchResult() {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 2,
      itemCount: _sampleImagesCollection.length,
      itemBuilder: (context, index) {
        return Container(
            constraints: BoxConstraints(
              maxWidth: (MediaQuery.of(context).size.width / 2) - 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.pureBlackColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                CachedNetworkImage(imageUrl: _sampleImagesCollection[index]));
      },
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
