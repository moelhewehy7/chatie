import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    this.validator,
    this.onchanged,
  });
  final String? Function(String?)? validator;
  final Function(String?)? onchanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onchanged,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        filled: true,
        hintText: "Email",
        prefixIcon: const Icon(
          Icons.email,
        ),
        // prefixIconColor: isDark ? Colors.white : Colors.black87,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(style: BorderStyle.solid, color: Colors.blueGrey)),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.validator,
    this.onchanged,
  });
  final String? Function(String?)? validator;
  final Function(String?)? onchanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool ishiding = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onChanged: widget.onchanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      obscureText: ishiding,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
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
              ? Icon(Icons.visibility_off)
              : Icon(
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
            borderSide:
                BorderSide(style: BorderStyle.solid, color: Colors.blueGrey)),
      ),
    );
  }
}
