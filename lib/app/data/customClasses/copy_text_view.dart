import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyTextView extends StatefulWidget {
  final String text;
  final bool obscureText;

  const CopyTextView({super.key, required this.text, this.obscureText = false});

  @override
  State<CopyTextView> createState() => _CopyTextViewState();
}

class _CopyTextViewState extends State<CopyTextView> {
  late bool _obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.text));
            },
            child: TextFormField(
              initialValue: widget.text,
              readOnly: true,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _obscureText ? '••••••••' : null,
              ),
            ),
          ),
        ),
        widget.obscureText
            ? IconButton(
                icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : Container( width: 24, height: 24,),
        IconButton(
          icon: const Icon(Icons.content_copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.text));
          },
        ),
      ],
    );
  }
}
