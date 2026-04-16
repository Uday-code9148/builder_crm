import 'package:temp_architecture_app_setup/core/enums/home_tab.dart';

/// Sub-pages accessible from within the home shell but not represented
/// as dedicated nav-bar tabs.
///
/// To add a new sub-page:
///   1. Add a value here with its [parentTab] (which nav tab to highlight).
///   2. Add a corresponding case to `_widgetForSubPage()` in home_page.dart.
///   3. Pass `onNavigateTo` to the feature page that triggers navigation.
enum AppSubPage {
  milestones(parentTab: HomeTab.more),
  profile(parentTab: HomeTab.more);

  final HomeTab parentTab;

  const AppSubPage({required this.parentTab});
}
