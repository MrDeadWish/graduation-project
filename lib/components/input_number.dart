import 'package:binevir/components/show_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/theme_icons.dart';
import '../helpers/math_helper.dart';
import 'dart:math' as math;

verifyMaxValue(
  String curValue,
  String oldValue,
  num maxValue,
  Function(String, bool)? call,
) {
  final double? value = double.tryParse(curValue);
  late bool res = false;
  if (value != null) {
    res = value > maxValue;
  }
  final String result = res ? oldValue : curValue;
  call?.call(result, res);
}

verifyMinValue(
  String curValue,
  String oldValue,
  num minValue,
  Function(String, bool)? call,
) {
  final double? value = double.tryParse(curValue);
  late bool res = false;
  if (value != null) {
    res = value < minValue;
  }
  final String result = res ? oldValue : curValue;
  call?.call(result, res);
}

verifyRange(
  String curValue,
  String oldValue,
  num minValue,
  num maxValue,
  Function(String, bool)? call,
) {
  final double? value = double.tryParse(curValue);
  late bool res = false;
  if (value != null) {
    res = value < minValue || value > maxValue;
  }
  final String result = res ? oldValue : curValue;
  call?.call(result, res);
}

String valueFormatter(dynamic value) {
  String extraZeros = '';

  extraZeros = '.';
  extraZeros = extraZeros.padRight(1 + 1, '0');

  NumberFormat formatter =
      NumberFormat('#,###,###,###,###,###,###,###,###,##0$extraZeros', 'en_US');

  return formatter.format(value);
}

class DecimalTextInputFormatter extends TextInputFormatter {
  final double? min;
  final double? max;
  DecimalTextInputFormatter({
    required this.decimalRange,
    required this.activatedNegativeValues,
    this.max,
    this.min,
  }) : assert(decimalRange >= 0,
            'DecimalTextInputFormatter declaretion error');

  final int decimalRange;
  final bool activatedNegativeValues;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String newValueText = newValue.text.replaceAll(',', '.');
    String truncated = newValueText;

    if (newValueText.contains(' ')) {
      return oldValue;
    }

    if (newValueText.isEmpty) {
      return newValue;
    } else if (double.tryParse(newValueText) == null &&
        !(newValueText.length == 1 &&
            (activatedNegativeValues == true) &&
            newValueText == '-')) {
      return oldValue;
    }

    if (activatedNegativeValues == false &&
        double.tryParse(newValueText)! < 0) {
      return oldValue;
    }

    // Minimum value check.
    if (min != null) {
      verifyMinValue(newValueText, oldValue.text, min!, (value, state) {
        truncated = value;
        if (state) {
          newSelection = oldValue.selection;
        }
      });
    }

    // Maximum value check.
    if (max != null) {
      verifyMaxValue(newValueText, oldValue.text, max!, (value, state) {
        truncated = value;
        if (state) {
          newSelection = oldValue.selection;
        }
      });
    }

    // Range check check
    if (min != null && max != null) {
      verifyRange(newValueText, oldValue.text, min!, max!, (value, state) {
        truncated = value;
        if (state) {
          newSelection = oldValue.selection;
        }
      });
    }

    String value = newValueText;

    if (decimalRange == 0 && value.contains(".")) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    }

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated.replaceAll('.', ','),
      selection: newSelection,
      composing: TextRange.empty,
    );
  
    return newValue;
  }
}

class NumberInput extends StatefulWidget {
  final String? placeholder;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final double? inputHeight;
  final double? inputFontSize;
  final double? inputLineHeight;
  final EdgeInsets? inputPadding;
  final InputBorder? border;
  final Function(String)? onChanged;
  final Function()? onEditingComplate;
  final bool? isModal;
  final double? step;
  final bool allowDecimal;
  final int? decimalRange;
  final double? maxValue;
  final double? minValue;
  final bool? negativeValues;
  final Widget? modalBody;
  final Widget? modalHeader;
  final String? suffix;
  const NumberInput({
    super.key,
    this.placeholder,
    this.label,
    this.decimalRange,
    this.step,
    this.maxValue,
    this.minValue,
    this.inputFormatters,
    this.controller,
    this.negativeValues,
    this.backgroundColor,
    this.hintStyle,
    this.onChanged,
    this.border,
    this.inputHeight,
    this.onEditingComplate,
    this.inputPadding,
    this.inputFontSize = 30.0,
    this.inputLineHeight = 1.2,
    this.isModal = false,
    this.modalHeader,
    this.modalBody,
    this.suffix,
    this.allowDecimal = false,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  bool suffixVisible = false;
  String placeholder = '';
  bool _isHovering = false;
  bool _isFocased = false;

  FocusNode textFocus = FocusNode();

  @override
  void initState() {
    placeholder = widget.placeholder!;
    textFocus.addListener(() {
      setState(() {
        _isFocased = textFocus.hasFocus;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    textFocus.dispose();

    super.dispose();
  }

  // both
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          textFocus.requestFocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null)
              Text(
                widget.label!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: InputDecorator(
                    expands: false,
                    isFocused: _isFocased,
                    isHovering: _isHovering,
                    decoration: InputDecoration(
                      filled: widget.backgroundColor != null ? true : false,
                      fillColor: widget.backgroundColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 14,
                      ),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IntrinsicWidth(
                              child: TextFormField(
                                readOnly: widget.isModal ?? false,
                                focusNode: textFocus,
                                controller: widget.controller,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: widget.allowDecimal,
                                ),
                                textInputAction: TextInputAction.done,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(_getRegexString())),
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    TextSelection newSelection =
                                        newValue.selection;
                                    String newValueText = newValue.text;
                                    double newValueDouble = 0.0;

                                    if (newValueText == '') {
                                      return newValue.copyWith(
                                        selection: newSelection,
                                        text: '',
                                        composing: TextRange.empty,
                                      );
                                    }

                                    if (widget.allowDecimal &&
                                        widget.decimalRange != null) {
                                      if (newValue.text.length > 1) {
                                        if (oldValue.text.contains(',') &&
                                            !newValue.text.contains(',')) {
                                          newValueText = oldValue.text;
                                        }
                                      }

                                      if (newValue
                                              .text[newValue.text.length - 1] ==
                                          ',') {
                                        newSelection =
                                            newValue.selection.copyWith(
                                          baseOffset: math.min(
                                              newValueText.length,
                                              newValueText.length - 1),
                                          extentOffset: math.min(
                                              newValueText.length,
                                              newValueText.length - 1),
                                        );
                                      }

                                      if (newValue.selection.baseOffset == 0) {
                                        newValueText = '';
                                      }

                                      if (newValueText != '') {
                                        newValueDouble = roundDouble(
                                            double.parse(newValueText
                                                .replaceAll(',', '.')),
                                            widget.decimalRange!);

                                        if (widget.minValue != null) {
                                          if (newValueDouble <
                                              widget.minValue!) {
                                            newValueDouble = widget.minValue!;
                                          }
                                        }
                                      }

                                      newValueText = newValueDouble.toString();

                                      if (newValue.selection.baseOffset == 0) {
                                        newValueText = '';
                                      }

                                      if (newValue.selection.baseOffset >
                                          newValueText.length) {
                                        newSelection = oldValue.selection;
                                        return newValue.copyWith(
                                          selection: newSelection,
                                          text: oldValue.text
                                              .replaceAll('.', ','),
                                          composing: TextRange.empty,
                                        );
                                      } else {
                                        return newValue.copyWith(
                                          selection: newSelection,
                                          text:
                                              newValueText.replaceAll('.', ','),
                                          composing: TextRange.empty,
                                        );
                                      }
                                    }

                                    return newValue;
                                  }),
                                ],
                                onEditingComplete: widget.onEditingComplate,
                                textAlignVertical: TextAlignVertical.top,
                                onTap: () {
                                  if (widget.isModal!) {
                                    showModal(
                                      context: context,
                                      child: widget.modalBody ??
                                          Text(AppLocalizations.of(context)!.noData),
                                      header: widget.modalHeader,
                                    );
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: placeholder,
                                  hintStyle: widget.hintStyle,
                                  isCollapsed: true,
                                  filled: widget.backgroundColor != null
                                      ? true
                                      : false,
                                  fillColor: widget.backgroundColor,
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                                style: TextStyle(
                                  fontSize: widget.inputFontSize,
                                  height: widget.inputLineHeight,
                                ),
                                onChanged: (value) {
                                  if (value == '') {
                                    setState(() {
                                      suffixVisible = false;
                                      placeholder = widget.placeholder!;
                                    });
                                  } else {
                                    setState(() {
                                      suffixVisible = true;
                                      placeholder = '';
                                    });
                                  }

                                  if (widget.onChanged != null)
                                    widget.onChanged!(value);
                                },
                              ),
                            ),
                            (widget.suffix != null && suffixVisible)
                                ? Text(
                                    widget.suffix!,
                                    style: TextStyle(
                                      fontSize: widget.inputFontSize,
                                      height: widget.inputLineHeight,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.step != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 20,
                          child: IconButton(
                            splashRadius: 30,
                            onPressed: () {
                              textFocus.unfocus();
                              String text =
                                  widget.controller!.text.replaceAll(',', '.');
                              double val =
                                  double.tryParse(text) ?? widget.minValue!;

                              dynamic currentValue = 0;

                              if (widget.maxValue! >= val &&
                                  widget.maxValue! >= val + widget.step!) {
                                currentValue = val + widget.step!;
                              } else {
                                currentValue = val;
                              }

                              String formattedValue =
                                  valueFormatter(currentValue);
                              widget.controller!.text = TextEditingValue(
                                      text: formattedValue,
                                      selection: TextSelection.collapsed(
                                          offset: formattedValue.length))
                                  .text
                                  .replaceAll('.', ',');

                              if (currentValue > 0) {
                                setState(() {
                                  suffixVisible = true;
                                  placeholder = '';
                                });
                              }

                              if (widget.onChanged != null)
                                widget.onChanged!(formattedValue);
                            },
                            icon: const Icon(AppIcons.arrowUp),
                            iconSize: 13,
                            padding: const EdgeInsets.all(0.0),
                            color: const Color.fromRGBO(217, 217, 217, 1),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 25,
                          child: IconButton(
                            splashRadius: 30,
                            selectedIcon: Text('sad'),
                            isSelected: true,
                            onPressed: () {
                              String text =
                                  widget.controller!.text.replaceAll(',', '.');
                              double val = double.tryParse(text) ?? 0;

                              dynamic currentValue = 0;

                              if (val > widget.minValue! &&
                                  (val - widget.step! > 0)) {
                                currentValue = val - widget.step!;
                              } else {
                                currentValue = val;
                              }

                              String formattedValue =
                                  valueFormatter(currentValue);
                              widget.controller!.text = TextEditingValue(
                                      text: formattedValue,
                                      selection: TextSelection.collapsed(
                                          offset: formattedValue.length))
                                  .text
                                  .replaceAll('.', ',');

                              if (currentValue <= 0) {
                                setState(() {
                                  suffixVisible = false;
                                  placeholder = widget.placeholder!;
                                  widget.controller!.text = '';
                                });
                              }

                              if (widget.onChanged != null)
                                widget.onChanged!(formattedValue);
                            },
                            icon: const Icon(AppIcons.arrowDown),
                            iconSize: 13,
                            padding: const EdgeInsets.all(0.0),
                            color: const Color.fromRGBO(217, 217, 217, 1),
                            focusColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRegexString() =>
      widget.allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
}
