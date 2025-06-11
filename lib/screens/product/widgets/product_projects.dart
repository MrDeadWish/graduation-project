import 'package:binevir/components/app_slider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductProjects extends StatelessWidget {
  final List<dynamic> slides;

  const ProductProjects({
    super.key,
    required this.slides,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
          child: Text(
            AppLocalizations.of(context)!.projects,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: -10,
                top: 0,
                right: -10,
                bottom: 0,
                child: AppSlider(
                  slidesCount: 3,
                  buttonLeftPositionTop: 42,
                  buttonLeftPositionLeft: 20,
                  buttonRightPositionRight: 20,
                  buttonRightPositionTop: 42,
                  containerPadding: EdgeInsets.zero,
                  buttonColor: const Color.fromARGB(255, 199, 137, 137),
                  slides: slides,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
