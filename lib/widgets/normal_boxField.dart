import 'package:flutter/material.dart';

class Normal_BoxField extends StatelessWidget {
  Normal_BoxField({super.key, this.passValue, this.title});
  Function(String? value)? passValue;
  String? title;

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    title ??= ''; //if
    _titleController.text = title!;
    return Container(
      width: double.infinity,
      child: TextField(
        controller: _titleController,
        onChanged: (value) => passValue!(value),
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            label: Text('input your title'),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      ),
    );
  }
}
