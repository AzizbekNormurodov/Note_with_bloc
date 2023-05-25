part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable{
  const NoteEvent();
}
class NoteAddEvent extends NoteEvent{
  final String note;

  const NoteAddEvent({required this.note});
  @override
  List <Object?> get props => [note];

}
class NoteRemoveEvent extends NoteEvent {
   final int index;

  const NoteRemoveEvent({required this.index});
   @override
   List <Object?> get props => [index];
}

class NoteUpdateEvent extends NoteEvent{
  final int index;
  final String note;

 const NoteUpdateEvent({ required this.index, required this.note});
  @override
  List <Object?> get props => [index, note];

}
