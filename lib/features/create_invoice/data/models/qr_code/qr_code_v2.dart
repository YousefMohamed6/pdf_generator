import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code.dart';

class QRCodeV2 extends QRCode {
  final String invoiceXML;
  final String ecdsaSignture;
  final String ecdsaPublicKey;
  final String? invoicesTaxSimplified;
  QRCodeV2({
    required super.sellerName,
    required super.sellerVatId,
    required super.invoiceDate,
    required super.totalAmount,
    required super.vatAmount,
    required this.invoiceXML,
    required this.ecdsaSignture,
    required this.ecdsaPublicKey,
    this.invoicesTaxSimplified,
  });
}
