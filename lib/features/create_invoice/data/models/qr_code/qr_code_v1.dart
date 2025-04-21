import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code.dart';

class QRCodeV1 extends QRCode {
  QRCodeV1({
    required super.sellerName,
    required super.sellerVatId,
    required super.invoiceDate,
    required super.totalAmount,
    required super.vatAmount,
  });
}
