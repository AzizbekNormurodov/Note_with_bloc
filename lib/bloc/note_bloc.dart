import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_event.dart';

part 'note_state.dart';


class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(const NoteState(notes: [])) {
    on<NoteAddEvent>(onAdd);
    on<NoteRemoveEvent>(onRemove);
    on<NoteUpdateEvent>(onUpdate);
  }

  void onAdd(NoteAddEvent event, Emitter <NoteState> emit) {
    emit(state.copyWith(notes: [...state.notes, event.note]));
  }

  void onRemove(NoteRemoveEvent event, Emitter <NoteState> emit) {
    emit(state.copyWith(notes: [
      for(int i = 0; i < state.notes.length; i++)
        if(i != event.index)
          state.notes[i]
    ],
    ),
    );
  }

  void onUpdate(NoteUpdateEvent event, Emitter <NoteState> emit) {
    emit(state.copyWith(notes: [
      for(int i = 0; i < state.notes.length; i++)
        if (i == event.index)
          event.note
        else
          state.notes[i]
    ],),
    );
  }

}