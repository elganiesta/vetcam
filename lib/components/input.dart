import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required TextEditingController nomController,
    required this.hint,
    required this.validator,
  })  : _nomController = nomController,
        super(key: key);

  final TextEditingController _nomController;
  final String hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: TextFormField(
        controller: _nomController,
        decoration: InputDecoration(
          hintText: hint,
        ),
        validator: validator,
      ),
    );
  }
}