import 'package:airmymd/domain/models/add_note_response.dart';
import 'package:airmymd/domain/models/get_notes_response.dart';
import 'package:airmymd/domain/usecases/authcases.dart';

class NotesPresenter {
  NotesPresenter(this._authCases);
  final AuthCases _authCases;

  Future<AddNoteResponse> addNote(
          {required bool isLoading,
          required String title,
          required String description,
          required String users,
          required String dateTime,
          required userId}) =>
      _authCases.addNote(
        isLoading: isLoading,
        title: title,
        description: description,
        users: users,
        dateTime: dateTime,
        userId: userId,
      );

  Future<GetNotesResponse> getNotes({
    required bool isLoading,
  }) =>
      _authCases.getNotes(
        isLoading: isLoading,
      );
}
