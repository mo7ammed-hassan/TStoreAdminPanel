import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/helpers/model_helper.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';
import 'package:t_store_admin_panel/data/models/addrees_model.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 5)
class UserModel extends HasId {
  @HiveField(0)
  final String? userID;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? userName;
  @HiveField(4)
  final String userEmail;
  @HiveField(5)
  final String? userPhone;
  @HiveField(6)
  final String? userProfilePicture;
  @HiveField(7)
  final AppRole? userRole;
  @HiveField(8)
  final DateTime? createdAt;
  @HiveField(9)
  final DateTime? updatedAt;
  
  @HiveField(10)
  final List<AddressModel>? userAddresses;
  @HiveField(11)
  final List<OrderModel>? userOrders;

  UserModel({
    this.userID,
    this.firstName,
    this.lastName,
    this.userName,
    required this.userEmail,
    this.userPhone,
    this.userProfilePicture,
    this.userRole,
    this.createdAt,
    this.updatedAt,
    this.userAddresses,
    this.userOrders,
  });

  UserModel copyWith({
    String? userID,
    String? firstName,
    String? lastName,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? userProfilePicture,
    AppRole? userRole,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<AddressModel>? userAddresses,
    List<OrderModel>? userOrders,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      userProfilePicture: userProfilePicture ?? this.userProfilePicture,
      userRole: userRole ?? this.userRole,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userAddresses: userAddresses ?? this.userAddresses,
      userOrders: userOrders ?? this.userOrders,
    );
  }

  String? get userFullName => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> json , [String? id]) {
    return UserModel(
      userID:
          ModelHelper.containsKeyAndNotEmpty(json, 'userId')
              ? json['userId']
              : null,
      firstName:
          ModelHelper.containsKeyAndNotEmpty(json, 'firstName')
              ? json['firstName']
              : null,
      lastName:
          ModelHelper.containsKeyAndNotEmpty(json, 'lastName')
              ? json['lastName']
              : null,
      userName:
          ModelHelper.containsKeyAndNotEmpty(json, 'username')
              ? json['username']
              : null,
      userEmail:
          ModelHelper.containsKeyAndNotEmpty(json, 'email')
              ? json['email']
              : null,
      userPhone:
          ModelHelper.containsKeyAndNotEmpty(json, 'phone')
              ? json['phone']
              : null,
      userProfilePicture:
          ModelHelper.containsKeyAndNotEmpty(json, 'profilePicture')
              ? json['profilePicture']
              : null,
      userRole:
          ModelHelper.containsKeyAndNotEmpty(json, 'role')
              ? json['role'] == AppRole.admin.name
                  ? AppRole.admin
                  : AppRole.user
              : null,
      createdAt:
          ModelHelper.containsKeyAndNotEmpty(json, 'createdAt')
              ? ModelHelper.parseDate(json['createdAt'])
              : null,
      updatedAt:
          ModelHelper.containsKeyAndNotEmpty(json, 'updatedAt')
              ? ModelHelper.parseDate(json['updatedAt'])
              : null,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    if (document.data() == null) return UserModel(userEmail: '');
    return UserModel.fromJson(document.data() as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => {
    'userId': userID,
    'firstName': firstName,
    'lastName': lastName,
    'username': userName,
    'email': userEmail,
    'phone': userPhone,
    'profilePicture': userProfilePicture,
    'role': userRole,
    'createdAt': Timestamp.fromDate(createdAt!),
    'updatedAt': Timestamp.fromDate(updatedAt!),
  };

  @override
  set id(String? id) {
    id = userID;
  }

  @override
  String get id => userID!;
}
