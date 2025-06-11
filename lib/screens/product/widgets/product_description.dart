import 'package:flutter/Material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDescription extends StatelessWidget {
  final String text;
  const ProductDescription({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 24,
        ),
        Text(
          AppLocalizations.of(context)!.description,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Text(
          text,
        ),
        const Divider(
          height: 24,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
