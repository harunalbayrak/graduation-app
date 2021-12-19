import 'package:graduation_app/models/app.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:device_apps/device_apps.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('Apps.db');

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
CREATE TABLE $tableApp (
  ${AppFields.id} $idType,
  ${AppFields.appName} $textType,
  ${AppFields.packageName} $textType,
  ${AppFields.version} $textType,
  ${AppFields.allowWifi} $boolType,
  ${AppFields.allowMobileNetwork} $boolType,
  ${AppFields.isInWhitelist} $boolType,
  ${AppFields.notificationMode} $boolType,
  ${AppFields.totalActivities_7days} $integerType,
  ${AppFields.icon} $textType
  )
''');
  }

  Future<App> create(App app) async {
    final db = await instance.database;
    final id = await db!.insert(tableApp, app.toJson());
    return app.copy(id: id);
  }

  Future<App> readApp(int id) async {
    final db = await instance.database;

    final maps = await db!.query(
      tableApp,
      columns: AppFields.values,
      where: '${AppFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return App.fromJson(maps.first);
    } else {
      //return null;
      throw Exception('ID: $id is not found');
    }
  }

  Future<App> readAppWithAppName(String appName) async {
    final db = await instance.database;

    final maps = await db!.query(
      tableApp,
      columns: AppFields.values,
      where: '${AppFields.appName} = ?',
      whereArgs: [appName],
    );

    if (maps.isNotEmpty) {
      return App.fromJson(maps.first);
    } else {
      //return null;
      throw Exception('AppName: $appName is not found');
    }
  }

  Future<List<App>> readAllApps() async {
    final db = await instance.database;

    final orderBy = '${AppFields.id} ASC';
    final result = await db!.query(tableApp, orderBy: orderBy);

    return result.map((json) => App.fromJson(json)).toList();
  }

  Future deleteRemovedApps() async {
    List<App> databaseApps = await readAllApps();

    List apps =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);

    int flag = 0;
    for (int i = 0; i < databaseApps.length; i++) {
      flag = 0;
      for (int j = 0; j < apps.length; j++) {
        if (apps[j].appName == databaseApps[i].appName) {
          flag = 1;
          break;
        }
      }
      if (flag == 0) {
        await deleteWithAppName(databaseApps[i].appName);
      }
    }
  }

  Future<int> update(App app) async {
    final db = await instance.database;

    return db!.update(
      tableApp,
      app.toJson(),
      where: '${AppFields.id} = ?',
      whereArgs: [app.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db!.delete(
      tableApp,
      where: '${AppFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteWithAppName(String appName) async {
    final db = await instance.database;

    return await db!.delete(
      tableApp,
      where: '${AppFields.appName} = ?',
      whereArgs: [appName],
    );
  }

  Future close() async {
    final db = await instance.database;

    db!.close();
  }
}
