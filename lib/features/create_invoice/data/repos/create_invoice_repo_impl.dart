import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf_generator/core/enums/qrcode_versions.dart';
import 'package:pdf_generator/core/services/file_manager_service.dart';
import 'package:pdf_generator/core/services/qrcode_generator.dart';
import 'package:pdf_generator/core/utils/constants/assets_manager.dart';
import 'package:pdf_generator/features/create_invoice/data/models/client_model/client_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/invoice_data/invoice_data_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/invoice_model/invoice_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code.dart';
import 'package:pdf_generator/features/create_invoice/data/models/vendor_model/vendor_model.dart';
import 'package:pdf_generator/features/create_invoice/domain/repos/i_create_invoice_repo.dart';

class CreateInvoiceRepoImpl implements ICreateInvoiceRepo {
  final FileManagerService fileManagerService;
  final QRCodeGenerator qrCodeGenerator;
  CreateInvoiceRepoImpl({
    required this.qrCodeGenerator,
    required this.fileManagerService,
  });
  @override
  Future<InvoiceModel> getInvoiceData({
    required int invoiceId,
    required int clientId,
  }) async {
    final Map<String, dynamic> response = await Future.value({
      "data":
          InvoiceDataModel(
            clientId: clientId,
            vendorId: 1,
            name: "Sell Invoice",
            invoiceNumber: invoiceId,
            date: DateTime.now(),
            vatAmount: 15.0,
            totalAmount: 115.0,
          ).toJson(),
      "client":
          ClientModel(
            id: clientId,
            arabicName: "العميل",
            englishName: "Client",
            balance: 0.0,
            taxNumber: "123456789",
            phoneNumber: "123-456-7890",
            address: "123 Main St",
            city: "New York",
            postalCode: 10001,
            country: "USA",
            email: "client@example.com",
          ).toJson(),
      "vendor":
          VendorModel(
            id: 1,
            arabicName: "المورد",
            englishName: "Vendor",
            balance: 0.0,
            taxNumber: "987654321",
            phoneNumber: "098-765-4321",
            address: "456 Elm St",
            city: "Los Angeles",
            postalCode: 90001,
            country: "USA",
            email: "vendor@example.com",
          ).toJson(),
    });
    final invoiceData = InvoiceDataModel.fromJson(response["data"]);
    final clientData = ClientModel.fromJson(response["client"]);
    final vendorData = VendorModel.fromJson(response["vendor"]);
    return InvoiceModel(
      invoiceData: invoiceData,
      client: clientData,
      vendor: vendorData,
    );
  }

  @override
  Future<Uint8List> getArialFontBytes() async {
    final ByteData arialFont = await rootBundle.load(AssetsManager.arialFont);
    return arialFont.buffer.asUint8List();
  }

  @override
  Future<String> createQRCode({
    required QRCode qrCode,
    required QRCodeVersion version,
  }) async {
    return await qrCodeGenerator.generateQrCode(
      qrCode: qrCode,
      version: version,
    );
  }

  @override
  Future<void> saveFile({
    required String fileName,
    required Uint8List bytes,
    bool handleDesktopSave = false,
  }) {
    return fileManagerService.saveFile(
      fileName: fileName,
      bytes: bytes,
      handleDesktopSave: handleDesktopSave,
    );
  }
}
