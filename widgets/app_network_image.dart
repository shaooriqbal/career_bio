import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatefulWidget {
  const AppNetworkImage({
    Key? key,
    required this.url,
    this.borderRadius,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);

  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius == null
          ? BorderRadius.zero
          : BorderRadius.circular(widget.borderRadius!),
      child: CachedNetworkImage(
        // alignment: Alignment.center,
        fit: widget.fit ?? BoxFit.cover,
        imageUrl: widget.url,
        width: widget.width,
        height: widget.height,
        // imageBuilder: (context, imageProvider) => Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: imageProvider,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
