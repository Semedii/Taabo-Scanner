import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.label,
    required this.prefixIcon,
    this.suffixWidget,
    this.initialvalue,
    this.isReadOnly = false,
    this.isObscure = false,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.validator,
    super.key,
  });

  final String label;
  final IconData prefixIcon;
  final Widget? suffixWidget;
  final String? initialvalue;
  final bool isReadOnly;
  final bool isObscure;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

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
        obscureText: isObscure,
        initialValue: initialvalue,
        readOnly: isReadOnly,
        decoration: _getTextFormFieldDecoration(),
        validator: validator,
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

  InputDecoration _getTextFormFieldDecoration() {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF6B7280)),
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF1e78c1)),
      suffix: suffixWidget,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(16),
    );
  }
}
