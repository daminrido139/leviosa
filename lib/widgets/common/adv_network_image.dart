import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdvancedNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  final bool? showLoading;
  final BoxFit? fit;
  const AdvancedNetworkImage({
    super.key,
    required this.imgUrl,
    this.width,
    this.height,
    this.showLoading,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: height,
      width: width,
      alignment: Alignment.center,
      fit: fit,
      progressIndicatorBuilder: (showLoading == null || showLoading == false)
          ? null
          : (BuildContext context, String data,
              DownloadProgress loadingProgress) {
              return Container(
                alignment: Alignment.center,
                width: width,
                height: height,
                color: Colors.grey.shade200,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.totalSize != null
                      ? loadingProgress.downloaded / loadingProgress.totalSize!
                      : null,
                ),
              );
            },
      errorWidget: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade900,
          alignment: Alignment.center,
          child: const Text(
            "Can't load!",
            style: TextStyle(fontSize: 12, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
