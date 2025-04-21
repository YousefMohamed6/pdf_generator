part of 'create_invoice_cubit.dart';

@freezed
class CreateInvoiceState<T> with _$CreateInvoiceState {
  const factory CreateInvoiceState.initial() = Initial;
  const factory CreateInvoiceState.loading() = Loading;
  const factory CreateInvoiceState.success(T data) = Success;
  const factory CreateInvoiceState.error(String message) = Error;
}
