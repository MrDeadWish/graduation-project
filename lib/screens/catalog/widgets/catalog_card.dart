import 'package:flutter/material.dart';

import '../../../../../components/cache_image.dart';

class CatalogCard extends StatelessWidget {
  final String title;
  final String image;
  final bool? list;
  final EdgeInsets? margin;

  const CatalogCard({
    super.key,
    required this.title,
    required this.image,
    this.list,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return list == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                color: const Color.fromRGBO(176, 177, 178, 1),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CachedImage(
                height: 200,
                width: double.infinity,
                imageUrl: image,
                fit: BoxFit.cover,
              ),
            ],
          )
        : Container(
            margin: margin ?? const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CachedImage(
                    height: 105,
                    width: 155,
                    imageUrl: image,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(87, 86, 86, 1),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
