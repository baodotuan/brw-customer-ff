import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'customer_app_setting_record.g.dart';

abstract class CustomerAppSettingRecord
    implements
        Built<CustomerAppSettingRecord, CustomerAppSettingRecordBuilder> {
  static Serializer<CustomerAppSettingRecord> get serializer =>
      _$customerAppSettingRecordSerializer;

  @nullable
  String get name;

  @nullable
  BuiltList<String> get options;

  @nullable
  int get value;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CustomerAppSettingRecordBuilder builder) =>
      builder
        ..name = ''
        ..options = ListBuilder()
        ..value = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('customer_app_setting');

  static Stream<CustomerAppSettingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  CustomerAppSettingRecord._();
  factory CustomerAppSettingRecord(
          [void Function(CustomerAppSettingRecordBuilder) updates]) =
      _$CustomerAppSettingRecord;

  static CustomerAppSettingRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCustomerAppSettingRecordData({
  String name,
  int value,
}) =>
    serializers.toFirestore(
        CustomerAppSettingRecord.serializer,
        CustomerAppSettingRecord((c) => c
          ..name = name
          ..options = null
          ..value = value));
