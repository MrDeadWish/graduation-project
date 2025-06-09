import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/image_helper.dart';
import 'select_photo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageModal extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const ImageModal({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -35,
          child: Container(
            width: 50,
            height: 6,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(children: [
          SelectPhoto(
            onTap: () async {
              final image = await getImage(ImageSource.gallery);
              if (image != null) {
                final File newImage = await copyImage(image, image.name);
                onChanged(newImage.path);
              }
            },
            icon: Icons.image,
            textLabel: AppLocalizations.of(context)!.browseInGallery,
          ),
          const SizedBox(
            height: 10,
          ),
          SelectPhoto(
            onTap: () async {
              final image = await getImage(
                ImageSource.camera,
              );
              onChanged(image.path);
            },
            icon: Icons.camera_alt_outlined,
            textLabel: AppLocalizations.of(context)!.useCamera,
          ),
        ])
      ],
    );
  }
}
