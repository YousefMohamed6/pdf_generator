# PDF Generator

A Flutter application for generating professional PDF invoices with QR codes and bilingual support (English and Arabic).

## Features

- Generate PDF invoices with customizable templates
- Support for both English and Arabic text
- QR code generation for invoice verification
- Client and vendor information management
- Professional PDF layout with tables and formatting
- A4 page size support with portrait orientation

## Technical Stack

- **Framework**: Flutter
- **State Management**: BLoC Pattern
- **Dependency Injection**: GetIt
- **Navigation**: GoRouter
- **PDF Generation**: Syncfusion Flutter PDF
- **QR Code Generation**: qr_flutter
- **File Management**: file_picker
- **Permissions**: permission_handler

## Project Structure

```
lib/
├── core/
│   ├── enums/
│   └── services/
├── features/
│   └── create_invoice/
│       ├── data/
│       │   ├── models/
│       │   └── repos/
│       ├── domain/
│       │   ├── repos/
│       │   └── use_cases/
│       └── presentation/
│           ├── manager/
│           ├── views/
│           └── widgets/
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (version compatible with SDK ^3.7.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Usage

1. Launch the application
2. Click the "Create Invoice" button
3. The application will generate a PDF invoice with the following features:
   - Bilingual header (English and Arabic)
   - Client information table
   - Vendor information table
   - QR code containing invoice details
   - Professional formatting and layout

## Dependencies

- bloc: ^9.0.0
- flutter_bloc: ^9.1.0
- syncfusion_flutter_pdf: ^29.1.38
- qr_flutter: ^4.1.0
- go_router: ^15.0.0
- get_it: ^8.0.3
- file_picker: ^10.1.2
- permission_handler: ^12.0.0+1

## Development

The project follows clean architecture principles with clear separation of concerns:
- Data Layer: Handles data models and repositories
- Domain Layer: Contains business logic and use cases
- Presentation Layer: Manages UI and state

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
