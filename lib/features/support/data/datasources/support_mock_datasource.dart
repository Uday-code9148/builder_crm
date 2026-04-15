import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_category.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_status.dart';
import 'package:temp_architecture_app_setup/features/support/data/datasources/support_datasource.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';

@LazySingleton(as: SupportDataSource)
class SupportMockDataSource implements SupportDataSource {
  @override
  Future<List<SupportTicketEntity>> getTickets() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      SupportTicketEntity(
        id: 'TCK-4921',
        category: TicketCategory.maintenance,
        title: 'HVAC Performance at Skyglass Penthouse',
        preview: 'Unit 402 reporting intermittent…',
        status: TicketStatus.inProgress,
        timeLabel: 'Resolution due in 18 hours',
        isUrgent: true,
      ),
      SupportTicketEntity(
        id: 'TCK-5012',
        category: TicketCategory.legal,
        title: 'Zoning Document Verification Request',
        preview: 'Client needs signed architectural…',
        status: TicketStatus.open,
        timeLabel: 'Due in 3 days',
      ),
      SupportTicketEntity(
        id: 'TCK-3882',
        category: TicketCategory.billing,
        title: 'Curation Fee Dispute – Q3',
        preview: 'Invoice reconciliation for the monthl…',
        status: TicketStatus.resolved,
        timeLabel: 'Closed Oct 24',
      ),
      SupportTicketEntity(
        id: 'TCK-4819',
        category: TicketCategory.security,
        title: 'Biometric Gate Access Failure',
        preview: 'Main gate scanner not recognizing…',
        status: TicketStatus.inProgress,
        timeLabel: 'Resolution due in 4 hours',
        isUrgent: true,
      ),
    ];
  }
}
