import 'package:flutter/material.dart';

class Expand_boxField extends StatelessWidget {
  Expand_boxField({super.key, this.getNote, this.note});
  Function(String? value)? getNote;
  String? note;

  @override
  Widget build(BuildContext context) {
    final _noteController = TextEditingController();
    note ??= ''; //if
    _noteController.text = note!;
    //must use expanded
    return TextField(
      controller: _noteController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: null,
      expands: true,
      onChanged: (value) => getNote!(value),
      decoration: const InputDecoration(
          label: Text(
            'Write Note Here...',
            textAlign: TextAlign.left,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
    );
  }
}
