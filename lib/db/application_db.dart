import 'package:graduation_app/models/application.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ApplicationDatabase {
  static final ApplicationDatabase instance = ApplicationDatabase._init();

  static Database? _database;

  ApplicationDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('applications.db');

    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableApplication (
  ${ApplicationFields.id} $idType,
  ${ApplicationFields.packageName} $textType,
  ${ApplicationFields.version} $textType,
  ${ApplicationFields.allowWifi} $boolType,
  ${ApplicationFields.allowMobileNetwork} $boolType,
  ${ApplicationFields.isInWhitelist} $boolType,
  ${ApplicationFields.notificationMode} $boolType,
  ${ApplicationFields.totalActivities_7days} $integerType,
  )
''');
  }

  Future<Application> create(Application app) async {
    final db = await instance.database;
    final id = await db!.insert(tableApplication, app.toJson());
    return app.copy(id: id);
  }

  Future<Application> readApplication(int id) async {
    final db = await instance.database;

    final maps = await db!.query(
      tableApplication,
      columns: ApplicationFields.values,
      where: '${ApplicationFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Application.fromJson(maps.first);
    } else {
      //return null;
      throw Exception('ID: $id is not found');
    }
  }

  Future<List<Application>> readAllApplications() async {
    final db = await instance.database;

    final orderBy = '${ApplicationFields.id} ASC';
    final result = await db!.query(tableApplication, orderBy: orderBy);

    return result.map((json) => Application.fromJson(json)).toList();
  }

  Future<int> update(Application app) async {
    final db = await instance.database;

    return db!.update(
      tableApplication,
      app.toJson(),
      where: '${ApplicationFields.id} = ?',
      whereArgs: [app.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db!.delete(
      tableApplication,
      where: '${ApplicationFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db!.close();
  }
}
