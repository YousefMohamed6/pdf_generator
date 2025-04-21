// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDataModel _$InvoiceDataModelFromJson(Map<String, dynamic> json) =>
    InvoiceDataModel(
      name: json['name'] as String,
      invoiceNumber: (json['invoiceNumber'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      clientId: (json['clientId'] as num).toInt(),
      vendorId: (json['vendorId'] as num).toInt(),
      vatAmount: (json['vatAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$InvoiceDataModelToJson(InvoiceDataModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'invoiceNumber': instance.invoiceNumber,
      'date': instance.date.toIso8601String(),
      'clientId': instance.clientId,
      'vendorId': instance.vendorId,
      'vatAmount': instance.vatAmount,
      'totalAmount': instance.totalAmount,
    };
