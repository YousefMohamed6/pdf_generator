import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_generator/features/create_invoice/presentation/manager/create_invoice_cubit.dart';

class CreateInvoiceButton extends StatelessWidget {
  const CreateInvoiceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      onPressed: () async {
        context.read<CreateInvoiceCubit>().createInvoice(
          invoiceId: 1,
          clientId: 1,
        );
      },
      child: const Text('Create Invoice'),
    );
  }
}
