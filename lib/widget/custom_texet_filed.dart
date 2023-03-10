import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.icon,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.labelText,
    this.controller,
    this.maxLength,
    this.suffixicon,
  });
  final String? labelText;
  final IconData? icon;
  final void Function()? onTap;
  final String? hintText;
  TextEditingController? controller = TextEditingController();
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  void Function(String)? onChanged;
  final int? maxLength;
  final Widget? suffixicon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onChanged: onChanged,
        maxLength: maxLength,
        onTap: onTap,
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixicon,
          icon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }
}
