/// Temporary visibility for design-board screens (subscription, swap offer detail, etc.).
///
/// Keep screen implementations in the repo; routes show [ComingSoonScreen] until
/// [showDesignBoardScreens] is set to `true`.
class AppReleaseFlags {
  AppReleaseFlags._();

  static const bool showDesignBoardScreens = false;
}
