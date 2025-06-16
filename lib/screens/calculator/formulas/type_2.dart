import 'package:binevir/components/cache_image.dart';
import 'package:binevir/components/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:binevir/components/input_number.dart';
import 'package:binevir/helpers/conversion_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShotcreteFormula extends StatefulWidget {
  final void Function(Widget) onResultChanged;
  final bool isSI;

  const ShotcreteFormula({
    super.key,
    required this.onResultChanged,
    required this.isSI,
  });

  @override
  State<ShotcreteFormula> createState() => _ShotcreteFormulaState();
}

class _ShotcreteFormulaState extends State<ShotcreteFormula> {
  final _sController = TextEditingController();
  final _barSpacingController = TextEditingController();
  double _mValue = 50.0;
  final List<double> _barSpacingOptions = [50.0, 100.0];

  void _recalculate() {
    double S = double.tryParse(_sController.text.replaceAll(',', '.')) ?? 0;
    double N = 0, d = 0, meshX = 0, meshY = 30000;
    String spacingText = '', meshSizeText = '';
    String imageUrl = '';

    if (!widget.isSI) {
      S = ConversionHelper.convertArea(S, UnitSystem.us, UnitSystem.si);
    }
    if (_mValue == 50.0) {
      d = 2.2;
      N = (1.1 * S / 24).ceilToDouble();
      meshX = 800;
    } else if (_mValue == 100.0) {
      d = 3;
      N = (1.1 * S / 36).ceilToDouble();
      meshX = 1200;
    }
    imageUrl =
        'https:\/\/binevir.bokus.ru\/storage\/app_products\/d0pGfN5ChOoEkdXMA8VH4CbROeFRVr-metaOCDQsdC10Lcg0YTQvtC90LAgMSAoMSkucG5n-.png';

    if (!widget.isSI) {
      d = ConversionHelper.convertLengthMmInch(d, UnitSystem.si, UnitSystem.us);
      meshX = ConversionHelper.convertLengthMmInch(meshX, UnitSystem.si,UnitSystem.us);
      meshY = ConversionHelper.convertLengthMmInch(meshY,UnitSystem.si,UnitSystem.us);
      spacingText =
          '${ConversionHelper.convertLengthMmInch(_mValue, UnitSystem.si, UnitSystem.us).toStringAsFixed(1)}x${ConversionHelper.convertLengthMmInch(_mValue, UnitSystem.si, UnitSystem.us).toStringAsFixed(1)} in';
    } else {
      spacingText = '${_mValue.toInt()}x${_mValue.toInt()} mm';
    }
    meshSizeText = '${meshX.toStringAsFixed(0)}x${meshY.toStringAsFixed(0)} ${ConversionHelper.suffixLength(widget.isSI ? UnitSystem.si : UnitSystem.us)}';
    final resultWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.commonQuantityOfMeshRolls} - ${N.toInt()}',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '${AppLocalizations.of(context)!.rebarDiameter} ${d.toStringAsFixed(3)} ${ConversionHelper.suffixLength(widget.isSI ? UnitSystem.si : UnitSystem.us)}',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '${AppLocalizations.of(context)!.spacing}: $spacingText',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '${AppLocalizations.of(context)!.meshSize}: $meshSizeText',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Center(
          child: CachedImage(
            imageUrl: imageUrl,
            width: double.infinity,
            height: 150,
          ),
        ),
      ],
    );

    widget.onResultChanged(resultWidget);
  }

  @override
  void initState() {
    super.initState();
    _sController.addListener(_recalculate);
    _barSpacingController.text =
        widget.isSI
            ? '${_mValue.toStringAsFixed(1)} mm'
            : '${ConversionHelper.convertLengthMmInch(_mValue, UnitSystem.si, UnitSystem.us).toStringAsFixed(1)} in';
  }

  @override
  void dispose() {
    _sController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = constraints.maxWidth / 2 - 10;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: itemWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.reinforcementArea,
                    maxLines: 2,
                  ),
                  NumberInput(
                    controller: _sController,
                    placeholder: widget.isSI ? '0 m²' : '0 ft²',
                    suffix: widget.isSI ? 'm²' : 'ft²',
                    allowDecimal: true,
                    decimalRange: 1,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.barSpacing),
                  NumberInput(
                    suffix: 'mm',
                    isModal: true,
                    modalHeader: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.barSpacing,
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    modalBody: StatefulBuilder(
                      builder: (context, setState) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: _barSpacingOptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: CustomCheckbox<String>(
                                value: _barSpacingOptions[index].toString(),
                                groupValue: _mValue.toString(),
                                title:
                                    widget.isSI
                                        ? '${_barSpacingOptions[index].toInt()} mm'
                                        : '${ConversionHelper.convertLengthMmInch(_barSpacingOptions[index], UnitSystem.si, UnitSystem.us).toStringAsFixed(1)} in',

                                onChanged: (value) {
                                  setState(() {
                                    _mValue = double.parse(value);
                                    _barSpacingController.text =
                                        widget.isSI
                                            ? '${_mValue.toStringAsFixed(1)} mm'
                                            : '${ConversionHelper.convertLengthMmInch(_mValue, UnitSystem.si, UnitSystem.us).toStringAsFixed(1)} in';

                                    Navigator.of(context).pop();
                                  });
                                  _recalculate();
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    controller: _barSpacingController,
                    placeholder: widget.isSI ? '0 mm' : '0 in',
                    onChanged: (value) {
                      setState(() {
                        _mValue = double.tryParse(value) ?? _mValue;
                      });
                      _recalculate();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
