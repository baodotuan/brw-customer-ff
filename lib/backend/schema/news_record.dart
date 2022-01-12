import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'news_record.g.dart';

abstract class NewsRecord implements Built<NewsRecord, NewsRecordBuilder> {
  static Serializer<NewsRecord> get serializer => _$newsRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get url;

  @nullable
  int get index;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(NewsRecordBuilder builder) => builder
    ..name = ''
    ..url = ''
    ..index = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('news');

  static Stream<NewsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<NewsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  NewsRecord._();
  factory NewsRecord([void Function(NewsRecordBuilder) updates]) = _$NewsRecord;

  static NewsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createNewsRecordData({
  String name,
  String url,
  int index,
}) =>
    serializers.toFirestore(
        NewsRecord.serializer,
        NewsRecord((n) => n
          ..name = name
          ..url = url
          ..index = index));
