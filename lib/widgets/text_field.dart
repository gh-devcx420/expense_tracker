import 'package:flutter/material.dart';

class ExpenseTrackerTextField extends StatelessWidget {
  const ExpenseTrackerTextField(
      {required this.controller,
      required this.borderColour,
      required this.inputFieldFillColour,
      required this.label,
      this.prefixText,
      this.textCapitalization,
      this.keyboardType,
      super.key});

  final TextEditingController controller;
  final Color borderColour;
  final Color inputFieldFillColour;
  final String label;
  final String? prefixText;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.labelSmall,
      controller: controller,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColour,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColour,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        prefixText: prefixText ?? '',
        prefixStyle: Theme.of(context).textTheme.labelSmall,
        filled: true,
        fillColor: inputFieldFillColour,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
