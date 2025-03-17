import 'package:nort/core/core.dart';
import 'package:nort/data/data.dart';

/// An abstract class that defines the contract for note repository operations.
abstract class NoteRepository {
  /// Adds a new note.
  ///
  /// Returns a tuple containing an [AppException] if an error occurs, and the ID of the added note if successful.
  Future<(AppException?, int?)> addNote(Note note, String pin);

  /// Updates an existing note.
  ///
  /// Takes a [Note] object as a parameter.
  /// Returns a tuple containing an [AppException] if an error occurs, and the ID of the updated note if successful.
  Future<(AppException?, int?)> updateNote(Note note, String pin);

  /// Deletes an existing note.
  ///
  /// Takes a [Note] object as a parameter.
  /// Returns a tuple containing an [AppException] if an error occurs, and the ID of the deleted note if successful.
  Future<(AppException?, bool)> deleteNote(Note note);

  /// Retrieves all notes.
  ///
  /// Returns a tuple containing an [AppException] if an error occurs, and a list of [Note] objects if successful.
  Future<(AppException?, List<Note>?)> getNotes();

  /// Retrieves a note by its ID.
  ///
  /// Takes an integer [id] as a parameter.
  /// Returns a tuple containing an [AppException] if an error occurs, and the [Note] object if found.
  Future<(AppException?, Note?)> getNoteById(int id);

  /// Decrypts a note by its ID.
  ///
  /// Takes an integer [id] as a parameter.
  /// Returns a tuple containing an [AppException] if an error occurs, and the decrypted [Note] object if successful.
  Future<(AppException?, Note?)> dcryptNote(int id, String pin);
}
