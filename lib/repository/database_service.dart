import 'package:runningam/repository/objectbox.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  late ObjectBox box = ObjectBox();

  DatabaseService._internal();

}
