import 'package:flutter/material.dart';
import 'package:binevir/components/input_number.dart';

class SubtractFormula extends StatefulWidget {
  final void Function(double) onResultChanged;

  const SubtractFormula({super.key, required this.onResultChanged});

  @override
  State<SubtractFormula> createState() => _SubtractFormulaState();
}

class _SubtractFormulaState extends State<SubtractFormula> {
  final _aController = TextEditingController();
  final _bController = TextEditingController();

  void _recalculate() {
    final a = double.tryParse(_aController.text.replaceAll(',', '.')) ?? 0;
    final b = double.tryParse(_bController.text.replaceAll(',', '.')) ?? 0;
    widget.onResultChanged(a - b);
  }

  @override
  void initState() {
    super.initState();
    _aController.addListener(_recalculate);
    _bController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberInput(
          controller: _aController,
          placeholder: 'Число A',
        ),
        const SizedBox(height: 10),
        NumberInput(
          controller: _bController,
          placeholder: 'Число B',
        ),
      ],
    );
  }
}
