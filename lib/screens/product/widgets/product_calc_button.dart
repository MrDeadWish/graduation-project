import 'package:binevir/components/primary_button.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCalcButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  const ProductCalcButton({
    this.margin = const EdgeInsets.only(bottom: 10.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      margin: margin,
      child: Align(
        child: PrimaryButton(
          onPressed: () {},
          child: Text(AppLocalizations.of(context)!.calculate.toUpperCase()),
        ),
      ),
    );
  }
}
