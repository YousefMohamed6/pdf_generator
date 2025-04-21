import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf_generator/features/create_invoice/domain/use_cases/create_invoice_use_case.dart';

part 'create_invoice_cubit.freezed.dart';
part 'create_invoice_state.dart';

class CreateInvoiceCubit extends Cubit<CreateInvoiceState> {
  final CreateInvoiceUseCase createInvoiceUseCase;
  CreateInvoiceCubit(this.createInvoiceUseCase)
    : super(CreateInvoiceState.initial());
  Future<void> createInvoice({
    required int invoiceId,
    required int clientId,
  }) async {
    try {
      emit(CreateInvoiceState.loading());
      await createInvoiceUseCase.execute(
        invoiceId: invoiceId,
        clientId: clientId,
      );
      emit(CreateInvoiceState<bool>.success(true));
    } catch (e) {
      emit(CreateInvoiceState.error(e.toString()));
    }
  }
}
