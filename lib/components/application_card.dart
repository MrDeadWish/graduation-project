import 'package:binevir/components/cache_image.dart';
import 'package:flutter/material.dart';

class ApplicationCard extends StatefulWidget {
  final String title;
  final String icon;
  final double? width;
  final bool? last;
  const ApplicationCard({
    super.key,
    required this.title,
    required this.icon,
    this.last = false,
    this.width,
  });

  @override
  State<ApplicationCard> createState() => _ApplicationCardState();
}

class _ApplicationCardState extends State<ApplicationCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              right: 4.0,
              left: 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedImage(
                  imageUrl: widget.icon,
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
