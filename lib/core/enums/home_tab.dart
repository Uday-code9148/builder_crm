import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';

enum HomeTab {
  home(label: 'Home', asset: ImageResources.icHome),
  payments(label: 'Payments', asset: ImageResources.icPayments),
  documents(label: 'Documents', asset: ImageResources.icDocuments),
  tickets(label: 'Tickets', asset: ImageResources.icUpdates),
  more(label: 'More', asset: ImageResources.icMore);

  final String label;
  final String asset;

  const HomeTab({required this.label, required this.asset});
}
