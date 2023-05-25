import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_with_bloc/bloc/note_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          "Your Task",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (_, state) {
          return ListView.separated(
              itemBuilder: (_, index) => ListTile(
                onTap: (){
                  _controller.text=state.notes[index];
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog( insetPadding: EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column( mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextField(
                                  controller: _controller,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<NoteBloc>().add(NoteUpdateEvent(index: index, note: _controller.text.trim())
                                    );
                                    _controller.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  context.read<NoteBloc>().add(NoteUpdateEvent(index: index, note: _controller.text.trim()));
                },
                    tileColor: Colors.white,
                    titleTextStyle: TextStyle(color: Colors.black),
                    title: Text(state.notes[index]),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<NoteBloc>()
                            .add(NoteRemoveEvent(index: index));
                      },
                      icon: Icon(Icons.delete, color: Colors.black,),
                    ),
                  ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: state.notes.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return Dialog( insetPadding: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column( mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _controller,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<NoteBloc>().add(
                                  NoteAddEvent(
                                    note: _controller.text.trim(),
                                  ),
                                );
                            _controller.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Add"),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
