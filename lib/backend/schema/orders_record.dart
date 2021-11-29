import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'orders_record.g.dart';

abstract class OrdersRecord
    implements Built<OrdersRecord, OrdersRecordBuilder> {
  static Serializer<OrdersRecord> get serializer => _$ordersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  BuiltList<DocumentReference> get items;

  @nullable
  int get total;

  @nullable
  @BuiltValueField(wireName: 'in_cart')
  bool get inCart;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  bool get transacted;

  @nullable
  @BuiltValueField(wireName: 'cash_payment')
  bool get cashPayment;

  @nullable
  @BuiltValueField(wireName: 'point_payment')
  bool get pointPayment;

  @nullable
  bool get pickup;

  @nullable
  bool get delivery;

  @nullable
  @BuiltValueField(wireName: 'total_quantity')
  int get totalQuantity;

  @nullable
  @BuiltValueField(wireName: 'pickup_address')
  String get pickupAddress;

  @nullable
  @BuiltValueField(wireName: 'delivery_address')
  String get deliveryAddress;

  @nullable
  @BuiltValueField(wireName: 'status_processing')
  bool get statusProcessing;

  @nullable
  @BuiltValueField(wireName: 'status_ready')
  bool get statusReady;

  @nullable
  @BuiltValueField(wireName: 'status_done')
  bool get statusDone;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(OrdersRecordBuilder builder) => builder
    ..items = ListBuilder()
    ..total = 0
    ..inCart = false
    ..transacted = false
    ..cashPayment = false
    ..pointPayment = false
    ..pickup = false
    ..delivery = false
    ..totalQuantity = 0
    ..pickupAddress = ''
    ..deliveryAddress = ''
    ..statusProcessing = false
    ..statusReady = false
    ..statusDone = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  OrdersRecord._();
  factory OrdersRecord([void Function(OrdersRecordBuilder) updates]) =
      _$OrdersRecord;

  static OrdersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createOrdersRecordData({
  DocumentReference userId,
  int total,
  bool inCart,
  DateTime createdTime,
  bool transacted,
  bool cashPayment,
  bool pointPayment,
  bool pickup,
  bool delivery,
  int totalQuantity,
  String pickupAddress,
  String deliveryAddress,
  bool statusProcessing,
  bool statusReady,
  bool statusDone,
}) =>
    serializers.toFirestore(
        OrdersRecord.serializer,
        OrdersRecord((o) => o
          ..userId = userId
          ..items = null
          ..total = total
          ..inCart = inCart
          ..createdTime = createdTime
          ..transacted = transacted
          ..cashPayment = cashPayment
          ..pointPayment = pointPayment
          ..pickup = pickup
          ..delivery = delivery
          ..totalQuantity = totalQuantity
          ..pickupAddress = pickupAddress
          ..deliveryAddress = deliveryAddress
          ..statusProcessing = statusProcessing
          ..statusReady = statusReady
          ..statusDone = statusDone));
