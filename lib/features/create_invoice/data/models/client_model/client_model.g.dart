// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) => ClientModel(
  id: (json['id'] as num).toInt(),
  arabicName: json['aName'] as String,
  englishName: json['eName'] as String,
  balance: (json['balance'] as num).toDouble(),
  taxNumber: json['taxNumber'] as String,
  address: json['address'] as String,
  city: json['city'] as String,
  postalCode: (json['postalCode'] as num).toInt(),
  country: json['country'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
);

Map<String, dynamic> _$ClientModelToJson(ClientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aName': instance.arabicName,
      'eName': instance.englishName,
      'balance': instance.balance,
      'taxNumber': instance.taxNumber,
      'address': instance.address,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
