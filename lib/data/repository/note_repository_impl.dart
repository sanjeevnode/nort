import 'package:nort/domain/domain.dart';
import 'package:nort/core/core.dart';
import 'package:nort/data/data.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl({
    required Database db,
    required PersistentStorage localStorage,
    required UserRepository userRepository,
  })  : _db = db,
        _localStorage = localStorage,
        _userRepository = userRepository;

  final Database _db;
  final PersistentStorage _localStorage;
  final UserRepository _userRepository;

  @override
  Future<(AppException?, int?)> addNote(
    Note note,
    int userId,
    String pin,
  ) async {
    try {
      final (_, user) = await _userRepository.getUser(id: userId);
      if (user == null) {
        return (UserNotFoundException(), null);
      }

      // Check for valid pin
      final isValid = SecureHash.compare(
        pin,
        user.salt!,
        user.masterPassword!,
      );
      if (!isValid) {
        return (InvalidCredentialsException(), null);
      }

      final salt = await EncryptionService.generateSalt();
      final key = await EncryptionService.generateKey(pin, salt);
      final text = await EncryptionService.encryptText(note.content, key);
      final encNote = note.copyWith(content: text, userId: userId, salt: salt);

      final id = await _db.insert(
        'notes',
        encNote.toDBMap(),
      );
      return (null, id);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, Note?)> dcryptNote(int id) {
    // TODO: implement dcryptNote
    throw UnimplementedError();
  }

  @override
  Future<(AppException?, int?)> deleteNote(Note note) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<(AppException?, Note?)> getNoteById(int id) {
    // TODO: implement getNoteById
    throw UnimplementedError();
  }

  @override
  Future<(AppException?, List<Note>?)> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<(AppException?, int?)> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
