import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  static late final Store __store;
  late final Store store = __store;
  late Admin? admin;

  static final Completer<void> __isInitialized = Completer();
  static final ObjectBox _instance = ObjectBox._internal();
  factory ObjectBox() => _instance;
  
  
  ObjectBox._create() {
    ObjectBox.__isInitialized.complete();
    if (Admin.isAvailable()) {
      // Keep a reference until no longer needed or manually closed.
      admin = Admin(store);
    }
    // Add any additional setup code, e.g. build queries.
  }

  ObjectBox._internal(){
   __create();
  }

  Future<void> initObjBox() async {
    return __isInitialized.future;
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static  __create() async {
      final docsDir = await getApplicationDocumentsDirectory();
      // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
      String path = p.join(docsDir.path, 'obx-runningham');
      print("Open objectbox $path");
      ObjectBox.__store = await openStore(directory: path);

      ObjectBox._create();
  }

}
