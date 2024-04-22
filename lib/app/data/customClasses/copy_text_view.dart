import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyTextView extends StatelessWidget {
  final String text;
  final bool obscureText;

  const CopyTextView({super.key, required this.text, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: text));
            },
            child: TextFormField(
              initialValue: text,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: obscureText ? '••••••••' : null,
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.content_copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
          },
        ),
      ],
    );
  }
}
