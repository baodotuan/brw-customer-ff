import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'vouchers_record.g.dart';

abstract class VouchersRecord
    implements Built<VouchersRecord, VouchersRecordBuilder> {
  static Serializer<VouchersRecord> get serializer =>
      _$vouchersRecordSerializer;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'on_bill')
  bool get onBill;

  @nullable
  @BuiltValueField(wireName: 'on_item')
  bool get onItem;

  @nullable
  double get discount;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(VouchersRecordBuilder builder) => builder
    ..name = ''
    ..onBill = false
    ..onItem = false
    ..discount = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('vouchers');

  static Stream<VouchersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  VouchersRecord._();
  factory VouchersRecord([void Function(VouchersRecordBuilder) updates]) =
      _$VouchersRecord;

  static VouchersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createVouchersRecordData({
  String name,
  bool onBill,
  bool onItem,
  double discount,
}) =>
    serializers.toFirestore(
        VouchersRecord.serializer,
        VouchersRecord((v) => v
          ..name = name
          ..onBill = onBill
          ..onItem = onItem
          ..discount = discount));
