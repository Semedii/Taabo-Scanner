import 'package:flutter/material.dart';
import 'package:taabo/utils/text_validators.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.label,
    required this.icon,
    this.initialvalue,
    this.isReadOnly = false,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  final String label;
  final IconData icon;
  final String? initialvalue;
  final bool isReadOnly;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [_getInputFieldBoxshadow()],
      ),
      child: TextFormField(
        textInputAction: textInputAction,
        autofocus: true,
        enabled: !isReadOnly,
        initialValue: initialvalue,
        readOnly: isReadOnly,
        decoration: _getTextFormFieldDecoration(label, icon),
        validator: TextValidators.required,
        onChanged: onChanged,
      ),
    );
  }

  BoxShadow _getInputFieldBoxshadow() {
    return const BoxShadow(
      color: Colors.black12,
      blurRadius: 4,
      offset: Offset(0, 2),
    );
  }

  InputDecoration _getTextFormFieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF6B7280)),
      prefixIcon: Icon(icon, color: const Color(0xFF1e78c1)),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(16),
    );
  }
}
