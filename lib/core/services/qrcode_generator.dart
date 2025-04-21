import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pdf_generator/core/enums/qrcode_versions.dart';
import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code.dart';
import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code_v1.dart';
import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code_v2.dart';

class QRCodeGenerator {
  Uint8List _encodeTLV(int tag, String value) {
    final List<int> bytes = utf8.encode(value);
    final int length = bytes.length;
    return Uint8List.fromList([tag, length, ...bytes]);
  }

  Future<String> generateQrCode({
    required QRCodeVersion version,
    required QRCode qrCode,
  }) async {
    if (version == QRCodeVersion.v1) {
      return await _generateQrCodeV1(qrCodeV1: qrCode as QRCodeV1);
    } else {
      return await _generateQrCodeV2(qrCodeV2: qrCode as QRCodeV2);
    }
  }

  Future<String> _generateQrCodeV1({required QRCodeV1 qrCodeV1}) async {
    List<int> qrData = [];
    qrData.addAll(_encodeTLV(0x01, qrCodeV1.sellerName));
    qrData.addAll(_encodeTLV(0x02, qrCodeV1.sellerVatId));
    qrData.addAll(_encodeTLV(0x03, qrCodeV1.invoiceDate));
    qrData.addAll(_encodeTLV(0x04, qrCodeV1.totalAmount));
    qrData.addAll(_encodeTLV(0x05, qrCodeV1.vatAmount));
    return base64.encode(qrData);
  }

  Future<String> _generateQrCodeV2({required QRCodeV2 qrCodeV2}) async {
    List<int> qrData = [];
    qrData.addAll(_encodeTLV(0x01, qrCodeV2.sellerName));
    qrData.addAll(_encodeTLV(0x02, qrCodeV2.sellerVatId));
    qrData.addAll(_encodeTLV(0x03, qrCodeV2.invoiceDate));
    qrData.addAll(_encodeTLV(0x04, qrCodeV2.totalAmount));
    qrData.addAll(_encodeTLV(0x05, qrCodeV2.vatAmount));
    qrData.addAll(_encodeTLV(0x06, _generateHash(qrCodeV2.invoiceXML)));
    qrData.addAll(_encodeTLV(0x07, qrCodeV2.ecdsaSignture));
    qrData.addAll(_encodeTLV(0x08, qrCodeV2.ecdsaPublicKey));
    qrData.addAll(_encodeTLV(0x09, qrCodeV2.invoicesTaxSimplified ?? ''));
    return base64.encode(qrData);
  }

  String _generateHash(String xmlContent) {
    final Uint8List bytes = utf8.encode(xmlContent);
    final Digest digest = sha256.convert(bytes);
    final String result = base64.encode(digest.bytes);
    return result;
  }
}
