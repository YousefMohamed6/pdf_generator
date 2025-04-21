import 'package:json_annotation/json_annotation.dart';

part 'client_model.g.dart';

@JsonSerializable()
class ClientModel {
  final int id;
  @JsonKey(name: 'aName')
  final String arabicName;
  @JsonKey(name: 'eName')
  final String englishName;
  final double balance;
  final String taxNumber;
  final String address;
  final String city;
  final int postalCode;
  final String country;
  final String email;
  final String phoneNumber;

  ClientModel({
    required this.id,
    required this.arabicName,
    required this.englishName,
    required this.balance,
    required this.taxNumber,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.email,
    required this.phoneNumber,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClientModelToJson(this);
}
