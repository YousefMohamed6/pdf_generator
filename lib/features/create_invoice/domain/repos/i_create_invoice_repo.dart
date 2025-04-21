import 'dart:typed_data';

import 'package:pdf_generator/core/enums/qrcode_versions.dart';
import 'package:pdf_generator/features/create_invoice/data/models/invoice_model/invoice_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code.dart';

abstract class ICreateInvoiceRepo {
  Future<InvoiceModel> getInvoiceData({
    required int invoiceId,
    required int clientId,
  });
  Future<Uint8List> getArialFontBytes();
  Future<String> createQRCode({
    required QRCode qrCode,
    required QRCodeVersion version,
  });
  Future<void> saveFile({
    required String fileName,
    required Uint8List bytes,
    bool handleDesktopSave = false,
  });
}
