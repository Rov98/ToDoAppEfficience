import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helper/provider_helper.dart';
import 'package:todo_app/misc.dart';
import 'package:todo_app/widgets/appbar_default.dart';
import 'package:todo_app/widgets/expand_boxField.dart';
import 'package:todo_app/widgets/normal_boxField.dart';

class Add_Todo extends StatefulWidget {
  Add_Todo({super.key, this.id, this.title, this.note});
  final int? id;
  String? title, note;

  @override
  State<Add_Todo> createState() => _Add_TodoState();
}

class _Add_TodoState extends State<Add_Todo> {
  void getTitleBox(String? value) {
    widget.title = value!;
  }

  void getNoteBox(String? value) {
    widget.note = value!;
  }

  void submitText() async {
    getTitleBox;
    getNoteBox;
    if (widget.id == null) {
      await Provider.of<Provider_Helper>(context, listen: false)
          .insertData(widget.title!, widget.note);
    } else {
      await Provider.of<Provider_Helper>(context, listen: false)
          .updateData(widget.id!, widget.title!, widget.note);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_Default(appName, context),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Normal_BoxField(passValue: getTitleBox, title: widget.id==null?'':widget.title),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Expand_boxField(getNote: getNoteBox, note: widget.id==null?'':widget.note),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: submitText, child: const Icon(Icons.save_rounded)),
    );
  }
}
