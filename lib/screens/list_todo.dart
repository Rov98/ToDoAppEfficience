import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helper/provider_helper.dart';
import 'package:todo_app/misc.dart';
import 'package:todo_app/misc/random_color_generator.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/widgets/appbar_default.dart';

class List_Todo extends StatefulWidget {
  const List_Todo({super.key});

  @override
  State<List_Todo> createState() => _List_TodoState();
}

class _List_TodoState extends State<List_Todo> {
  void _tapDetail(int? id, String? title, note) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => Add_Todo(
        id: id,
        title: title,
        note: note,
      ),
    ))
        .then((value) {
      setState(() {
        //rebuild
      });
    });
  }

  void _tapIcon(int? id) {
    Provider.of<Provider_Helper>(context, listen: false)
        .deleteData(id!)
        .then((value) {
      setState(() {
        //rebuild
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appName),
        ),
        body: Container(
          child: FutureBuilder(
            future: Provider.of<Provider_Helper>(context, listen: false)
                .getAllNotes(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<Provider_Helper>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.notesItem!.length,
                          itemBuilder: (context, index) {
                            if (value.notesItem!.isEmpty) {
                              return const Center(
                                  child: Text('not a single note added'));
                            }
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                tileColor: getRandomColor(),
                                textColor: Colors.white,
                                title: Text(
                                  value.notesItem![index].title.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                subtitle: Text(
                                    value.notesItem![index].note.toString(),
                                    overflow: TextOverflow.clip),
                                trailing: IconButton(
                                  onPressed: () =>
                                      _tapIcon(value.notesItem![index].id),
                                  icon:
                                      const Icon(Icons.delete_forever_rounded),
                                ),
                                onTap: () => _tapDetail(
                                  value.notesItem![index].id,
                                  value.notesItem![index].title,
                                  value.notesItem![index].note,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_Todo(),
            ));
          },
        ));
  }
}
