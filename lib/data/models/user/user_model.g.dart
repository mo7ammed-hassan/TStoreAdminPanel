// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 5;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userID: fields[0] as String?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      userName: fields[3] as String?,
      userEmail: fields[4] as String,
      userPhone: fields[5] as String?,
      userProfilePicture: fields[6] as String?,
      userRole: fields[7] as AppRole?,
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
      userAddresses: (fields[10] as List?)?.cast<AddressModel>(),
      userOrders: (fields[11] as List?)?.cast<OrderModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.userEmail)
      ..writeByte(5)
      ..write(obj.userPhone)
      ..writeByte(6)
      ..write(obj.userProfilePicture)
      ..writeByte(7)
      ..write(obj.userRole)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.userAddresses)
      ..writeByte(11)
      ..write(obj.userOrders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
