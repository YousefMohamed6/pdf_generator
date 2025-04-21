import 'package:flutter/material.dart';
import 'package:pdf_generator/features/create_invoice/presentation/widgets/create_invoice_button.dart';

class CreateInvoiceView extends StatelessWidget {
  const CreateInvoiceView({super.key});
  static const String routeName = '/createInvoice';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Invoice')),
      body: CreateInvoiceBody(),
    );
  }
}

class CreateInvoiceBody extends StatelessWidget {
  const CreateInvoiceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Center(child: CreateInvoiceButton())]);
  }
}
