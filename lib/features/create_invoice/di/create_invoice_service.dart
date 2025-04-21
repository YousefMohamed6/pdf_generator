import 'package:get_it/get_it.dart';
import 'package:pdf_generator/core/extensions/getit_extension.dart';
import 'package:pdf_generator/core/services/file_manager_service.dart';
import 'package:pdf_generator/core/services/qrcode_generator.dart';
import 'package:pdf_generator/features/create_invoice/data/repos/create_invoice_repo_impl.dart';
import 'package:pdf_generator/features/create_invoice/domain/repos/i_create_invoice_repo.dart';
import 'package:pdf_generator/features/create_invoice/domain/use_cases/create_invoice_use_case.dart';
import 'package:pdf_generator/features/create_invoice/presentation/manager/create_invoice_cubit.dart';

class CreateInvoiceService {
  final sl = GetIt.instance;
  void initDi() {
    sl.registerLazySingletonSafely<QRCodeGenerator>(() => QRCodeGenerator());
    sl.registerLazySingletonSafely<FileManagerService>(
      () => FileManagerService(),
    );
    sl.registerLazySingletonSafely<ICreateInvoiceRepo>(
      () => CreateInvoiceRepoImpl(
        fileManagerService: sl<FileManagerService>(),
        qrCodeGenerator: sl<QRCodeGenerator>(),
      ),
    );
    sl.registerLazySingletonSafely<CreateInvoiceUseCase>(
      () => CreateInvoiceUseCase(sl<ICreateInvoiceRepo>()),
    );
    sl.registerFactorySafely<CreateInvoiceCubit>(
      () => CreateInvoiceCubit(sl<CreateInvoiceUseCase>()),
    );
  }
}
