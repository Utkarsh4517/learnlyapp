import 'package:flutter/material.dart';
import 'package:learnlyapp/constants/dimensions.dart';

class DetailsTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  const DetailsTextField({
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  State<DetailsTextField> createState() => _DetailsTextFieldState();
}

class _DetailsTextFieldState extends State<DetailsTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getScreenWidth(context) * 0.07,
        vertical: getScreenWidth(context) * 0.04,
      ),
      child: SizedBox(
        height: getScreenWidth(context) * 0.2,
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8)),
              filled: true,
              labelText: widget.label,
              fillColor: const Color.fromARGB(255, 247, 247, 247),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white))),
        ),
      ),
    );
  }
}
