import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_generator/features/create_invoice/di/create_invoice_service.dart';
import 'package:pdf_generator/features/create_invoice/domain/repos/i_create_invoice_repo.dart';
import 'package:pdf_generator/features/create_invoice/presentation/manager/create_invoice_cubit.dart';
import 'package:pdf_generator/features/create_invoice/presentation/views/create_invoice_view.dart';

class RouterManager {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter routeConfig = GoRouter(
    redirect: (context, state) {
      return CreateInvoiceView.routeName;
    },
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: CreateInvoiceView.routeName,
        name: CreateInvoiceView.routeName,
        builder: (context, state) {
          CreateInvoiceService().initDi();
          return RepositoryProvider(
            create: (context) => GetIt.I.get<ICreateInvoiceRepo>(),
            child: BlocProvider(
              create: (context) => GetIt.I.get<CreateInvoiceCubit>(),
              child: CreateInvoiceView(),
            ),
          );
        },
      ),
    ],
  );
}
