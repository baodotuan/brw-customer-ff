import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  DateTime get birth;

  @nullable
  int get point;

  @nullable
  @BuiltValueField(wireName: 'processing_order')
  BuiltList<DocumentReference> get processingOrder;

  @nullable
  @BuiltValueField(wireName: 'in_cart_order')
  DocumentReference get inCartOrder;

  @nullable
  @BuiltValueField(wireName: 'loyalty_card_point')
  int get loyaltyCardPoint;

  @nullable
  @BuiltValueField(wireName: 'total_topup')
  int get totalTopup;

  @nullable
  @BuiltValueField(wireName: 'total_spent')
  int get totalSpent;

  @nullable
  @BuiltValueField(wireName: 'total_app_order')
  int get totalAppOrder;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..firstName = ''
    ..lastName = ''
    ..point = 0
    ..processingOrder = ListBuilder()
    ..loyaltyCardPoint = 0
    ..totalTopup = 0
    ..totalSpent = 0
    ..totalAppOrder = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String firstName,
  String lastName,
  DateTime birth,
  int point,
  DocumentReference inCartOrder,
  int loyaltyCardPoint,
  int totalTopup,
  int totalSpent,
  int totalAppOrder,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..firstName = firstName
          ..lastName = lastName
          ..birth = birth
          ..point = point
          ..processingOrder = null
          ..inCartOrder = inCartOrder
          ..loyaltyCardPoint = loyaltyCardPoint
          ..totalTopup = totalTopup
          ..totalSpent = totalSpent
          ..totalAppOrder = totalAppOrder));
