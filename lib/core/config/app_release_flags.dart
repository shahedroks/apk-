/// Routes gated behind [showDesignBoardScreens] show [ComingSoonScreen] when false.
///
/// Gated: notifications, subscription checkout, swap completed, reviews, public
/// profile, my matches.
///
/// Always visible: incoming/review offer, propose swap, invitation sent, chat.
class AppReleaseFlags {
  AppReleaseFlags._();

  static const bool showDesignBoardScreens = false;
}