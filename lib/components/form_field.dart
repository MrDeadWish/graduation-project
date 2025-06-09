import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final EdgeInsetsGeometry? labelMargin;
  final double? labelWidth;
  final Widget field;
  final bool? required;

  const InputField({
    super.key,
    required this.label,
    this.labelMargin,
    required this.field,
    this.labelWidth = 100,
    this.required,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.labelWidth,
          margin: widget.labelMargin ?? const EdgeInsets.only(top: 3.0),
          child: Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Color.fromRGBO(83, 83, 83, 1)),
          ),
        ),
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: widget.field),
              SizedBox(
                width: 5,
                child: widget.required != null
                    ? Transform.translate(
                        offset: const Offset(3, -3),
                        child: const Text('*'),
                      )
                    : null,
              )
            ],
          ),
        ),
      ],
    );
  }
}
