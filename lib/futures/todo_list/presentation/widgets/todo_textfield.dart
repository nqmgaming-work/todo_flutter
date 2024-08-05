import 'package:flutter/material.dart';

class TodoTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLength;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final String value;
  final TextInputAction textInputAction;

  const TodoTextField({
    super.key,
    required this.textController,
    required this.hintText,
    required this.validator,
    this.maxLength = 100,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.value = '',
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    textController.text = value; // Update the text controller with the value
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          textInputAction: TextInputAction.next,
          onTap: onTap,
          readOnly: readOnly,
          cursorColor: Colors.indigo,
          controller: textController,
          maxLength: maxLength,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.indigo,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}