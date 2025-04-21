import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pdf_generator/core/enums/qrcode_versions.dart';
import 'package:pdf_generator/features/create_invoice/data/models/client_model/client_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/invoice_model/invoice_model.dart';
import 'package:pdf_generator/features/create_invoice/data/models/qr_code/qr_code_v1.dart';
import 'package:pdf_generator/features/create_invoice/data/models/vendor_model/vendor_model.dart';
import 'package:pdf_generator/features/create_invoice/domain/repos/i_create_invoice_repo.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CreateInvoiceUseCase {
  final ICreateInvoiceRepo _repository;
  CreateInvoiceUseCase(this._repository);
  Future<void> execute({required int invoiceId, required int clientId}) async {
    final InvoiceModel invoice = await _repository.getInvoiceData(
      invoiceId: invoiceId,
      clientId: clientId,
    );
    // Create a new PDF document
    final PdfDocument document = PdfDocument(
      conformanceLevel: PdfConformanceLevel.a3b,
    );
    // Set the page size to A4
    document.pageSettings.size = PdfPageSize.a4;
    // Set the page orientation to portrait
    document.pageSettings.orientation = PdfPageOrientation.portrait;
    // Add a new page to the document
    final PdfPage page = document.pages.add();
    // Get the page width
    final double width = page.getClientSize().width;
    // Get the page height
    final double height = page.getClientSize().height;
    // Get the graphics object of the page
    final PdfGraphics graphics = page.graphics;
    // Create a font object using the loaded font data
    final Uint8List fontData = await _repository.getArialFontBytes();
    final PdfFont font = PdfTrueTypeFont(fontData, 12);
    // Draw Invoice Name
    _drawText(
      graphics,
      invoice.invoiceData.name,
      font,
      Rect.fromLTWH(width / 2, 0, width, 0),
    );
    // Draw Client Table
    _drawClientTable(
      page: page,
      font: font,
      width: width,
      height: height,
      graphics: graphics,
      client: invoice.client,
    );
    // Draw Vendor Table
    _drawVendorTable(
      page: page,
      font: font,
      width: width,
      height: height,
      graphics: graphics,
      vendor: invoice.vendor,
    );
    // Generate a QR Code
    final String qrCodeBase64 = await _repository.createQRCode(
      qrCode: QRCodeV1(
        sellerName:
            "${invoice.vendor.arabicName} ${invoice.vendor.englishName}",
        invoiceDate: invoice.invoiceData.date.toIso8601String(),
        totalAmount: invoice.invoiceData.totalAmount.toString(),
        vatAmount: invoice.invoiceData.vatAmount.toString(),
        sellerVatId: invoice.vendor.taxNumber,
      ),
      version: QRCodeVersion.v1,
    );
    // Draw QR Code on the page
    await _drawQRCode(qrCodeBase64, graphics, width, 100);
    final bytes = await document.save();
    // dispose the document to free up resources
    document.dispose();
    // Save the document to a file
    await _repository.saveFile(
      fileName: 'invoice$invoiceId.pdf',
      bytes: Uint8List.fromList(bytes),
    );
  }

  void _drawText(
    PdfGraphics graphics,
    String text,
    PdfFont font,
    Rect bounds, {
    PdfBrush? brush,
  }) {
    graphics.drawString(
      text,
      font,
      bounds: bounds,
      brush: brush ?? PdfBrushes.black,
    );
  }

  void _drawClientTable({
    required PdfPage page,
    required PdfFont font,
    required double width,
    required double height,
    required PdfGraphics graphics,
    required ClientModel client,
  }) {
    // Create a PdfGrid object
    final PdfGrid grid = PdfGrid();
    // Set the grid style
    grid.style.font = font;
    // Set the number of columns in the grid
    grid.columns.add(count: 2);
    // Add a header row to the grid
    final PdfGridRow header = grid.headers.add(1)[0];
    // Set the header style
    header.cells[0].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    header.cells[1].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
      textDirection: PdfTextDirection.rightToLeft,
    );
    // Set the header text for each column
    header.cells[0].value = 'Client';
    header.cells[1].value = 'العميل';
    // ============= Client Name ==================
    // Add a new row to the grid
    final PdfGridRow row = grid.rows.add();
    // Set the cell value for the first column
    row.cells[0].value = "Client Name\t${client.englishName}";
    // Set the cell value for the first column
    header.cells[0].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    // Set the cell value for the second column
    row.cells[1].value = "اسم العميل\t${client.arabicName}";
    // Set the cell value for the second column
    row.cells[1].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
      textDirection: PdfTextDirection.rightToLeft,
    );
    // Draw the grid on the page
    grid.draw(page: page, bounds: Rect.fromLTWH(0, 50, width / 2, height));
  }

  void _drawVendorTable({
    required PdfPage page,
    required PdfFont font,
    required double width,
    required double height,
    required PdfGraphics graphics,
    required VendorModel vendor,
  }) {
    // Create a PdfGrid object
    final PdfGrid grid = PdfGrid();
    // Set the grid style
    grid.style.font = font;
    // Set the number of columns in the grid
    grid.columns.add(count: 2);
    // Add a header row to the grid
    final PdfGridRow header = grid.headers.add(1)[0];
    // Set the header style
    header.cells[0].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    header.cells[1].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
      textDirection: PdfTextDirection.rightToLeft,
    );
    // Set the header text for each column
    header.cells[0].value = 'Vendor';
    header.cells[1].value = 'المورد';
    // ============= Client Name ==================
    // Add a new row to the grid
    final PdfGridRow row = grid.rows.add();
    // Set the cell value for the first column
    row.cells[0].value = "Vendor Name\t${vendor.englishName}";
    // Set the cell value for the first column
    header.cells[0].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    // Set the cell value for the second column
    row.cells[1].value = "اسم المورد\t${vendor.arabicName}";
    // Set the cell value for the second column
    row.cells[1].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
      textDirection: PdfTextDirection.rightToLeft,
    );
    // Draw the grid on the page
    grid.draw(
      page: page,
      bounds: Rect.fromLTWH((width / 2) + 20, 50, 0, height),
    );
  }

  Future<void> _drawQRCode(
    String base64,
    PdfGraphics graphics,
    double width,
    int qrSize,
  ) async {
    // Check if the string is valid for conversion to a QR code.
    final qrValidationResult = QrValidator.validate(
      data: base64,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    if (qrValidationResult.status == QrValidationStatus.valid) {
      final QrCode? qrCode = qrValidationResult.qrCode;
      if (qrCode == null) return;
      // Create a QrPainter object with the QR code data
      final painter = QrPainter.withQr(
        qr: qrCode,
        eyeStyle: const QrEyeStyle(color: Color(0xFF000000)),
      );
      // convert the QR code data to image data
      final ByteData? pictureData = await painter.toImageData(
        1800,
        format: ui.ImageByteFormat.png,
      );
      final imageBytes = pictureData?.buffer.asUint8List();
      if (imageBytes == null) return;
      // Create a PdfBitmap object from the image bytes
      final PdfBitmap qrImage = PdfBitmap(imageBytes);
      // Draw the QR code image on the page
      graphics.drawImage(
        qrImage,
        Rect.fromLTWH(
          (width / 2) - 50,
          200,
          qrSize.toDouble(),
          qrSize.toDouble(),
        ),
      );
    }
  }
}
