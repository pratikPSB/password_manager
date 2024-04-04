import 'package:password_manager/app/data/db/CredentialsModel.dart';
import 'package:password_manager/app/data/db/VaultModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../generated/objectBox/objectbox.g.dart';

class ObjectBox {
  late final Store _store;

  late final Box<CredentialsModel> _credentialsBox;
  late final Box<VaultModel> _vaultBox;

  ObjectBox._create(this._store) {
    _credentialsBox = Box<CredentialsModel>(_store);
    _vaultBox = Box<VaultModel>(_store);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore(
        directory: join((await getApplicationDocumentsDirectory()).path, "password-manager"),
        macosApplicationGroup: "password.manager");
    return ObjectBox._create(store);
  }

  //get stream list of all credentials
  Stream<List<CredentialsModel>> getCredentials() {
    final builder = _credentialsBox.query().order(CredentialsModel_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  //add new credential
  Future<void> addCredential(CredentialsModel post) => _credentialsBox.putAsync(post);

  //remove credential
  Future<void> removeCredential(int uniqueId) => _credentialsBox.removeAsync(uniqueId);

  //get stream list of all vaults
  Stream<List<VaultModel>> getVaults() {
    final builder = _vaultBox.query();
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  //add new vault
  Future<int> addVault(VaultModel post) => _vaultBox.putAsync(post);

  //remove vault
  Future<void> removeVault(int uniqueId) => _vaultBox.removeAsync(uniqueId);
}
