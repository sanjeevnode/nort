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

  Future<int> get userId async {
    final id = await _localStorage.read(key: AppConstant.localUserId);
    final userId = int.tryParse(id.toString());
    if (userId == null) {
      throw UserNotLoggedInException();
    }
    return userId;
  }

  @override
  Future<(AppException?, int?)> addNote(
    Note note,
    String pin,
  ) async {
    try {
      final userId = await this.userId;
      final (_, user) = await _userRepository.getUser(
        id: int.tryParse(userId.toString()),
      );
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

      final noteId = await _db.insert(
        'notes',
        encNote.toDBMap(),
      );
      return (null, noteId);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, Note?)> dcryptNote(int id, String pin) {
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
  Future<(AppException?, List<Note>?)> getNotes() async {
    try {
      final userId = await this.userId;
      final notes = await _db.query(
        'notes',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      final List<Note> noteList = notes.map((e) => Note.fromMap(e)).toList();
      return (null, noteList);
    } catch (e) {
      return (e.toAppException(), null);
    }
  }

  @override
  Future<(AppException?, int?)> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
