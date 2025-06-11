import 'package:flutter/material.dart';

class CustomCheckbox<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final bool? rtl;
  final String? title;
  final double? width;
  final double? height;
  final Color? selectedColor;
  final bool? disabled;
  final MainAxisAlignment mainAxisAlignment;
  final ValueChanged<T> onChanged;
  final TextStyle? textStyle;

  const CustomCheckbox({
    super.key,
    this.height = 26,
    this.width = 26,
    this.selectedColor,
    this.rtl = false,
    this.title = '',
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textStyle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    bool selected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        textDirection: rtl == true ? TextDirection.rtl : TextDirection.ltr,
        children: [
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 200,
            ),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: selected
                  ? Theme.of(context).primaryColor
                  : (disabled != true
                      ? Colors.white
                      : Colors.black.withAlpha(20)),
              borderRadius: BorderRadius.circular(5),
              border: selected
                  ? null
                  : Border.all(
                      width: 1.0,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
            ),
            child: selected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 17,
                  )
                : null,
          ),
          if (title != null)
            const SizedBox(
              width: 5.0,
            ),
          if (title != null)
            Text(
              title!,
              style: textStyle,
            ),
        ],
      ),
    );
  }
}
