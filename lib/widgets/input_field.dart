import 'package:flutter/material.dart';

inputField(
    {String? hintText, controller, context, obscureText = false, validator}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.7,
    child: TextFormField(
      validator: validator,
      controller: controller,
      style: Theme.of(context).textTheme.titleSmall,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall,
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: const Color(0xFFe8f0fd),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    ),
  );
}
