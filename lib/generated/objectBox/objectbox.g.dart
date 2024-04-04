// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../../app/data/db/CredentialsModel.dart';
import '../../app/data/db/VaultModel.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 8176031653072006250),
      name: 'CredentialsModel',
      lastPropertyId: const obx_int.IdUid(15, 3069482214139120658),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1979106187780207290),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4175963333742327360),
            name: 'vaultId',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2119007448479195285),
            name: 'credType',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 2330836632270523685),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 2695580226059334903),
            name: 'email',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 5133701385677807927),
            name: 'password',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 5021582654259269251),
            name: 'websites',
            type: 30,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 1556586442814132249),
            name: 'notes',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 3134236786021946817),
            name: 'nameOnCard',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 4041055144427789223),
            name: 'cardNumber',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 7256321212006453918),
            name: 'expiryDate',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(12, 8768654641230468087),
            name: 'cvvCode',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(13, 2179557567610334391),
            name: 'cardPin',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(14, 2767379020994138799),
            name: 'createdAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(15, 3069482214139120658),
            name: 'updatedAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 154367247481733975),
      name: 'VaultModel',
      lastPropertyId: const obx_int.IdUid(6, 1582668453177198878),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 3538744771495067067),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1839340833803044546),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 3699404140035333083),
            name: 'vaultColor',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 2161531852947082650),
            name: 'iconPath',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 5482521063574432999),
            name: 'createdAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 1582668453177198878),
            name: 'updatedAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(2, 154367247481733975),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    CredentialsModel: obx_int.EntityDefinition<CredentialsModel>(
        model: _entities[0],
        toOneRelations: (CredentialsModel object) => [],
        toManyRelations: (CredentialsModel object) => {},
        getId: (CredentialsModel object) => object.id,
        setId: (CredentialsModel object, int id) {
          object.id = id;
        },
        objectToFB: (CredentialsModel object, fb.Builder fbb) {
          final vaultIdOffset =
              object.vaultId == null ? null : fbb.writeString(object.vaultId!);
          final credTypeOffset = object.credType == null
              ? null
              : fbb.writeString(object.credType!);
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          final websitesOffset = object.websites == null
              ? null
              : fbb.writeList(object.websites!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final notesOffset =
              object.notes == null ? null : fbb.writeString(object.notes!);
          final nameOnCardOffset = object.nameOnCard == null
              ? null
              : fbb.writeString(object.nameOnCard!);
          final cardNumberOffset = object.cardNumber == null
              ? null
              : fbb.writeString(object.cardNumber!);
          final expiryDateOffset = object.expiryDate == null
              ? null
              : fbb.writeString(object.expiryDate!);
          final cvvCodeOffset =
              object.cvvCode == null ? null : fbb.writeString(object.cvvCode!);
          final cardPinOffset =
              object.cardPin == null ? null : fbb.writeString(object.cardPin!);
          fbb.startTable(16);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, vaultIdOffset);
          fbb.addOffset(2, credTypeOffset);
          fbb.addOffset(3, nameOffset);
          fbb.addOffset(4, emailOffset);
          fbb.addOffset(5, passwordOffset);
          fbb.addOffset(6, websitesOffset);
          fbb.addOffset(7, notesOffset);
          fbb.addOffset(8, nameOnCardOffset);
          fbb.addOffset(9, cardNumberOffset);
          fbb.addOffset(10, expiryDateOffset);
          fbb.addOffset(11, cvvCodeOffset);
          fbb.addOffset(12, cardPinOffset);
          fbb.addInt64(13, object.createdAt?.millisecondsSinceEpoch);
          fbb.addInt64(14, object.updatedAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createdAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 30);
          final updatedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 32);
          final vaultIdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final credTypeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final emailParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 12);
          final passwordParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 14);
          final websitesParam = const fb.ListReader<String>(
                  fb.StringReader(asciiOptimization: true),
                  lazy: false)
              .vTableGetNullable(buffer, rootOffset, 16);
          final notesParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 18);
          final nameOnCardParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 20);
          final cardNumberParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 22);
          final expiryDateParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 24);
          final cvvCodeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 26);
          final cardPinParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 28);
          final createdAtParam = createdAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(createdAtValue);
          final updatedAtParam = updatedAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(updatedAtValue);
          final object = CredentialsModel(
              vaultId: vaultIdParam,
              credType: credTypeParam,
              name: nameParam,
              email: emailParam,
              password: passwordParam,
              websites: websitesParam,
              notes: notesParam,
              nameOnCard: nameOnCardParam,
              cardNumber: cardNumberParam,
              expiryDate: expiryDateParam,
              cvvCode: cvvCodeParam,
              cardPin: cardPinParam,
              createdAt: createdAtParam,
              updatedAt: updatedAtParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    VaultModel: obx_int.EntityDefinition<VaultModel>(
        model: _entities[1],
        toOneRelations: (VaultModel object) => [],
        toManyRelations: (VaultModel object) => {},
        getId: (VaultModel object) => object.id,
        setId: (VaultModel object, int id) {
          object.id = id;
        },
        objectToFB: (VaultModel object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final vaultColorOffset = object.vaultColor == null
              ? null
              : fbb.writeString(object.vaultColor!);
          final iconPathOffset = object.iconPath == null
              ? null
              : fbb.writeString(object.iconPath!);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, vaultColorOffset);
          fbb.addOffset(3, iconPathOffset);
          fbb.addInt64(4, object.createdAt?.millisecondsSinceEpoch);
          fbb.addInt64(5, object.updatedAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final createdAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final updatedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 14);
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final vaultColorParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final iconPathParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 10);
          final createdAtParam = createdAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(createdAtValue);
          final updatedAtParam = updatedAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(updatedAtValue);
          final object = VaultModel(
              name: nameParam,
              vaultColor: vaultColorParam,
              iconPath: iconPathParam,
              createdAt: createdAtParam,
              updatedAt: updatedAtParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [CredentialsModel] entity fields to define ObjectBox queries.
class CredentialsModel_ {
  /// see [CredentialsModel.id]
  static final id =
      obx.QueryIntegerProperty<CredentialsModel>(_entities[0].properties[0]);

  /// see [CredentialsModel.vaultId]
  static final vaultId =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[1]);

  /// see [CredentialsModel.credType]
  static final credType =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[2]);

  /// see [CredentialsModel.name]
  static final name =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[3]);

  /// see [CredentialsModel.email]
  static final email =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[4]);

  /// see [CredentialsModel.password]
  static final password =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[5]);

  /// see [CredentialsModel.websites]
  static final websites = obx.QueryStringVectorProperty<CredentialsModel>(
      _entities[0].properties[6]);

  /// see [CredentialsModel.notes]
  static final notes =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[7]);

  /// see [CredentialsModel.nameOnCard]
  static final nameOnCard =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[8]);

  /// see [CredentialsModel.cardNumber]
  static final cardNumber =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[9]);

  /// see [CredentialsModel.expiryDate]
  static final expiryDate =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[10]);

  /// see [CredentialsModel.cvvCode]
  static final cvvCode =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[11]);

  /// see [CredentialsModel.cardPin]
  static final cardPin =
      obx.QueryStringProperty<CredentialsModel>(_entities[0].properties[12]);

  /// see [CredentialsModel.createdAt]
  static final createdAt =
      obx.QueryDateProperty<CredentialsModel>(_entities[0].properties[13]);

  /// see [CredentialsModel.updatedAt]
  static final updatedAt =
      obx.QueryDateProperty<CredentialsModel>(_entities[0].properties[14]);
}

/// [VaultModel] entity fields to define ObjectBox queries.
class VaultModel_ {
  /// see [VaultModel.id]
  static final id =
      obx.QueryIntegerProperty<VaultModel>(_entities[1].properties[0]);

  /// see [VaultModel.name]
  static final name =
      obx.QueryStringProperty<VaultModel>(_entities[1].properties[1]);

  /// see [VaultModel.vaultColor]
  static final vaultColor =
      obx.QueryStringProperty<VaultModel>(_entities[1].properties[2]);

  /// see [VaultModel.iconPath]
  static final iconPath =
      obx.QueryStringProperty<VaultModel>(_entities[1].properties[3]);

  /// see [VaultModel.createdAt]
  static final createdAt =
      obx.QueryDateProperty<VaultModel>(_entities[1].properties[4]);

  /// see [VaultModel.updatedAt]
  static final updatedAt =
      obx.QueryDateProperty<VaultModel>(_entities[1].properties[5]);
}
