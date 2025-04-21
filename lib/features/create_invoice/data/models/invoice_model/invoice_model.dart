import 'package:json_annotation/json_annotation.dart';
import 'package:pdf_generator/features/create_invoice/data/models/client_model/client_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/invoice_data/invoice_data_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/vendor_model/vendor_model.dart';

@JsonSerializable()
class InvoiceModel {
  final InvoiceDataModel invoiceData;
  final ClientModel client;
  final VendorModel vendor;

  InvoiceModel({
    required this.invoiceData,
    required this.client,
    required this.vendor,
  });
}
