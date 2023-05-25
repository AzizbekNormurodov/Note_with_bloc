part  of 'note_bloc.dart';

class NoteState extends Equatable {
  final List<String> notes;

  const NoteState({required this.notes});

  NoteState copyWith({List<String>? notes}) {
    return NoteState(notes: notes ?? this.notes);
  }
  @override
  List<Object?> get props => [notes];
}
