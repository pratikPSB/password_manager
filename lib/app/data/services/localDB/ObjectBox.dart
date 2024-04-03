import 'package:password_manager/app/data/db/CredentialsModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../generated/objectBox/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store _store;

  /// A Box of posts.
  late final Box<CredentialsModel> _credentialsBox;

  ObjectBox._create(this._store) {
    _credentialsBox = Box<CredentialsModel>(_store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final store = await openStore(
        directory: join((await getApplicationDocumentsDirectory()).path, "password-manager"),
        macosApplicationGroup: "password.manager");
    return ObjectBox._create(store);
  }

  Stream<List<CredentialsModel>> getCredentials() {
    final builder = _credentialsBox.query().order(CredentialsModel_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Future<void> addCredential(CredentialsModel post) => _credentialsBox.putAsync(post);

  Future<void> addPostsList(List<CredentialsModel> list) async {
    List<CredentialsModel> finalList = [];
    for (var element in list) {
      if (_credentialsBox
          .query(CredentialsModel_.id.greaterOrEqual(element.id))
          .build()
          .find()
          .isEmpty) {
        finalList.add(element);
      }
    }
    _credentialsBox.putManyAsync(finalList, mode: PutMode.insert);
  }

  Future<void> removeCredential(int uniqueId) => _credentialsBox.removeAsync(uniqueId);
}
