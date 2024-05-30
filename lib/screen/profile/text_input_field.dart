import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  const TextInput({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = "hintText",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.labelSmall,
      cursorRadius: const Radius.circular(8),
      cursorColor: Colors.black,
      cursorWidth: 1.8,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        // prefixIcon: const Icon(Remix.search_2_line),
      ),
    );
  }
}
