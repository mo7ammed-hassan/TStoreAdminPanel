// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 4;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      docId: fields[0] as String?,
      orderId: fields[1] as String?,
      userId: fields[2] as String?,
      orderStatus: fields[3] as OrderStatus?,
      totalAmount: fields[4] as double?,
      orderDate: fields[5] as DateTime?,
      paymentMethod: fields[6] as String?,
      shippingAddress: fields[7] as AddressModel?,
      billingAddress: fields[8] as AddressModel?,
      deliveryDate: fields[9] as DateTime?,
      cartItems: (fields[10] as List?)?.cast<CartItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.docId)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.orderStatus)
      ..writeByte(4)
      ..write(obj.totalAmount)
      ..writeByte(5)
      ..write(obj.orderDate)
      ..writeByte(6)
      ..write(obj.paymentMethod)
      ..writeByte(7)
      ..write(obj.shippingAddress)
      ..writeByte(8)
      ..write(obj.billingAddress)
      ..writeByte(9)
      ..write(obj.deliveryDate)
      ..writeByte(10)
      ..write(obj.cartItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
