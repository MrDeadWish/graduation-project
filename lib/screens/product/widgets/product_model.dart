import 'package:flutter/Material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductModel extends StatelessWidget {
  final String src;
  final bool? isGradient;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const ProductModel({
    super.key,
    this.isGradient = false,
    this.height = 300,
    this.margin,
    required this.src,
  });

  @override
  Widget build(BuildContext context) {
    //print('Используется модель $src');
    return Container(
      height: height,
      margin: margin,
      width: double.infinity,
      decoration: isGradient == true
          ? const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(217, 217, 217, 0.4),
                  Color.fromRGBO(217, 217, 217, 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            )
          : null,
      child: ModelViewer(
        src: src,
        //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        ar: true,
        autoRotate: true,
        cameraControls: true,
        cameraOrbit: '45deg 55deg 10m',
        relatedJs:
            "document.querySelector('model-viewer').innerHTML += '<div class=${'"loader"'}>${AppLocalizations.of(context)!.loadingModel}</div>'; const modelViewer = document.querySelector('model-viewer'); modelViewer.addEventListener('model-visibility', function(evt) { document.querySelector('.loader').style.display='none';})",
        relatedCss:
            'model-viewer{  --progress-bar-color: transparent;} body, html{ overflow: hidden;} .loader{position: absolute; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;}',
      ),
    );
  }
}
