import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_admin_panel/core/utils/helpers/model_helper.dart';

class AddressModel {
  final String? addressId;
  final String? userName;
  final String? phoneNumber;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? selectedAddress;

  AddressModel({
    this.addressId,
    this.userName,
    this.phoneNumber,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.createdAt,
    this.updatedAt,
    this.selectedAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressId:
          ModelHelper.containsKeyAndNotEmpty(json, 'addressId')
              ? json['addressId']
              : null,
      userName:
          ModelHelper.containsKeyAndNotEmpty(json, 'name') // userName
              ? json['name']
              : null,
      phoneNumber:
          ModelHelper.containsKeyAndNotEmpty(json, 'phoneNumber')
              ? json['phoneNumber']
              : null,
      street:
          ModelHelper.containsKeyAndNotEmpty(json, 'street')
              ? json['street']
              : null,
      city:
          ModelHelper.containsKeyAndNotEmpty(json, 'city')
              ? json['city']
              : null,
      state:
          ModelHelper.containsKeyAndNotEmpty(json, 'state')
              ? json['state']
              : null,
      country:
          ModelHelper.containsKeyAndNotEmpty(json, 'country')
              ? json['country']
              : null,
      postalCode:
          ModelHelper.containsKeyAndNotEmpty(json, 'postalCode')
              ? json['postalCode']
              : null,
      createdAt:
          ModelHelper.containsKeyAndNotEmpty(json, 'createdAt')
              ? ModelHelper.parseDate(json['createdAt'])
              : null,
      updatedAt:
          ModelHelper.containsKeyAndNotEmpty(json, 'updatedAt')
              ? ModelHelper.parseDate(json['updatedAt'])
              : null,
      selectedAddress:
          ModelHelper.containsKeyAndNotEmpty(json, 'selectedAddress')
              ? json['selectedAddress']
              : null,
    );
  }

  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot) {
    if(snapshot.data() == null) return AddressModel();
    return AddressModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
