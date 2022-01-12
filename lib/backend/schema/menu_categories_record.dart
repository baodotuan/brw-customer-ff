import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'menu_categories_record.g.dart';

abstract class MenuCategoriesRecord
    implements Built<MenuCategoriesRecord, MenuCategoriesRecordBuilder> {
  static Serializer<MenuCategoriesRecord> get serializer =>
      _$menuCategoriesRecordSerializer;

  @nullable
  String get name;

  @nullable
  int get index;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MenuCategoriesRecordBuilder builder) => builder
    ..name = ''
    ..index = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('menuCategories');

  static Stream<MenuCategoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<MenuCategoriesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  MenuCategoriesRecord._();
  factory MenuCategoriesRecord(
          [void Function(MenuCategoriesRecordBuilder) updates]) =
      _$MenuCategoriesRecord;

  static MenuCategoriesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createMenuCategoriesRecordData({
  String name,
  int index,
}) =>
    serializers.toFirestore(
        MenuCategoriesRecord.serializer,
        MenuCategoriesRecord((m) => m
          ..name = name
          ..index = index));
