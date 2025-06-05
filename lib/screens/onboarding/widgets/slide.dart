import 'package:flutter/material.dart';
import 'package:binevir/components/cache_image.dart';

class Slide extends StatefulWidget {
  final String? description;
  final String? title;
  final String? image;
  final PageController controller;

  
  const Slide({
    super.key,
    this.title,
    this.description,
    this.image,
    required this.controller,
  });

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 280.0,
          margin: const EdgeInsets.only(bottom: 30),
           child: CachedImage(
            height: 500,
            width: double.infinity,
            imageUrl: widget.image ?? '',
            )
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                widget.title!.toUpperCase()
              ),
                      const SizedBox(
                        height: 30,
                      ),
              Text(
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                      widget.description!,
                    ),
            ],
          ))
      ],
    );
  }
}
