class DashboardNavigationMapper {
  const DashboardNavigationMapper._();

  static int? tabIndexForQuickAction(String label) {
    switch (label) {
      case 'Payments':
        return 1;
      case 'Documents':
        return 2;
      case 'Support':
        return 3;
      default:
        return null;
    }
  }
}
