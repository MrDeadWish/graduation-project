import 'package:binevir/components/cache_image.dart';
import 'package:flutter/material.dart';

class ProductProjectItem extends StatelessWidget {
  final String image;
  const ProductProjectItem({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      color: Colors.black.withAlpha(10),
      child: CachedImage(
        imageUrl: image,
        height: 109,
      ),
    );
  }
}
