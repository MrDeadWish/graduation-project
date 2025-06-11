import 'package:binevir/components/app_slider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductApplications extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final List<dynamic> slides;

  const ProductApplications({
    super.key,
    this.margin,
    required this.slides,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.application,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          AppSlider(slidesCount: 5, slides: slides),
        ],
      ),
    );
  }
}
