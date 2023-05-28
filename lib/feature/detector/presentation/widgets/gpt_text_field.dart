import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

class GPTTextField extends StatelessWidget {
  const GPTTextField({
    required this.controller,
    required this.onChanged,
    required this.hintText,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: const Color(0x0fffffff),
      controller: controller,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.multiline,
      expands: true,
      maxLines: null,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(16, 16, 32, 40),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 16,
        ),
      ),
    );
  }
}
