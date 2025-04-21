import 'package:json_annotation/json_annotation.dart';

part 'invoice_data_model.g.dart';

@JsonSerializable()
class InvoiceDataModel {
  final String name;
  final int invoiceNumber;
  final DateTime date;
  final int clientId;
  final int vendorId;
  final double vatAmount;
  final double totalAmount;

  InvoiceDataModel({
    required this.name,
    required this.invoiceNumber,
    required this.date,
    required this.clientId,
    required this.vendorId,
    required this.vatAmount,
    required this.totalAmount,
  });
  factory InvoiceDataModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceDataModelToJson(this);
}
