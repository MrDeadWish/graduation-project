import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<DropdownMenuItem>? items;
  final String? Function(dynamic)? validator;
  final void Function(dynamic)? onChanged;
  final void Function(dynamic)? onSaved;
  final value;
  final double? height;
  final String? hint;
  const Dropdown({
    super.key,
    required this.items,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.hint,
    this.height = 25,
    this.value,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      isExpanded: true,
      hint: widget.hint != null
          ? Text(
              widget.hint!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            )
          : null,
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black45,
          size: 15,
        ),
        iconEnabledColor: Colors.red,
        iconDisabledColor: Colors.grey,
      ),
      value: widget.value,
      items: widget.items,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Colors.black,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        padding: EdgeInsets.zero,
        elevation: 2,
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.only(left: 10, right: 10),
      ),
      buttonStyleData: const ButtonStyleData(
        height: 35,
        padding: EdgeInsets.only(left: 0, right: 10),
        elevation: 2,
      ),
    );
  }
}
