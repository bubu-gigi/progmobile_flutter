import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF6136FF), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF6136FF), width: 2),
        ),
      ),
      dropdownColor: const Color(0xFF232323),
      style: const TextStyle(color: Colors.white),
      items: [
        DropdownMenuItem<T>(
          value: null,
          child: Text(
            label == 'Sport' ? 'Tutti' : 'Tutte',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        ...items.map(
              (item) => DropdownMenuItem<T>(
            value: item,
            child: Text(labelBuilder(item), style: const TextStyle(color: Colors.white)),
          ),
        )
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
