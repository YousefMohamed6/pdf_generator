abstract class QRCode {
  final String sellerName;
  final String sellerVatId;
  final String invoiceDate;
  final String totalAmount;
  final String vatAmount;

  QRCode({
    required this.sellerName,
    required this.sellerVatId,
    required this.invoiceDate,
    required this.totalAmount,
    required this.vatAmount,
  });
}