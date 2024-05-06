import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {super.key,
      this.validator,
      this.onchanged,
      required this.hinttext,
      required this.icon,
      required this.controller,
      this.autofocus = false,
      this.borderSide = BorderSide.none});
  final Function(String)? onchanged;
  final String hinttext;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool autofocus;
  final BorderSide borderSide;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onchanged,
      autofocus: autofocus,
      controller: controller,
      validator: validator,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        filled: true,
        hintText: hinttext,
        prefixIcon: Icon(icon),
        // prefixIconColor: isDark ? Colors.white : Colors.black87,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), borderSide: borderSide),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.validator,
    required this.controller,
  });
  final String? Function(String?)? validator;

  final TextEditingController controller;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool ishiding = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      obscureText: ishiding,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        filled: true,
        hintText: "Password",
        prefixIcon: const Icon(
          Icons.password,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            ishiding = !ishiding;
            setState(() {});
          },
          icon: ishiding
              ? const Icon(Icons.visibility_off)
              : const Icon(
                  Icons.visibility,
                ),
        ),
        // IconlyLight.hide
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Theme.of(context).colorScheme.onSurface)),
      ),
    );
  }
}
