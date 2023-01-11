import 'package:flutter/cupertino.dart';
import 'package:todo_app/helper/db_helper.dart';
import 'package:todo_app/model/Notes.dart';

class Provider_Helper extends ChangeNotifier {
  //we make a note maps;
  List<Notes>? _notes;

  List<Notes>? get notesItem {
    return _notes;
  }

  Future<void> getAllNotes() async {
    final getDb = await (await DBhelper.fetchData());
    _notes = [
      ...getDb.map((e) => Notes(
          id: e['id'] as int,
          title: e['title'].toString(),
          note: e['note'].toString()))
    ];
    notifyListeners();
  }

  Future<void> insertData(String title, note) async {
    final uniqueId = UniqueKey().hashCode;
    final getDb = await DBhelper.insert(uniqueId, title, note);
    _notes!.add(Notes(id: uniqueId, title: title, note: note));
    notifyListeners();
  }

  Future<void> updateData(int id, String title, note) async {
    final getDb = await DBhelper.update(id, title, note);
    final findId = _notes!.indexWhere((element) => element.id == id);
    _notes![findId].title = title;
    _notes![findId].note = note;
    notifyListeners();
  }

  Future<void> deleteData(int id) async {
    final getDb = await DBhelper.delete(id);
    final findId = _notes!.indexWhere((element) => element.id == id);
    _notes!.removeAt(findId);
    notifyListeners();
  }
}
