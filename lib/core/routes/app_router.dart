import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/extra_strings.dart';
import '../constants/match_strings.dart';
import '../constants/subscription_strings.dart';
import '../firebase/auth_refresh_listenable.dart';
import '../storage/auth_session.dart';
import 'screen_gate.dart';
import '../../features/auth/presentation/screens/check_email_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/chat/presentation/screens/chat_conversation_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/item/presentation/screens/add_item_screen.dart';
import '../../features/item/presentation/screens/add_item_success_screen.dart';
import '../../features/item/presentation/screens/item_detail_screen.dart';
import '../../features/item/presentation/screens/my_items_screen.dart';
import '../../features/item/presentation/screens/propose_swap_screen.dart';
import '../../features/item/presentation/screens/swap_invitation_sent_screen.dart';
import '../../features/extra/presentation/screens/notifications_screen.dart';
import '../../features/extra/presentation/screens/public_profile_screen.dart';
import '../../features/extra/presentation/screens/reviews_screen.dart';
import '../../features/extra/presentation/screens/swap_completed_screen.dart';
import '../../features/match/presentation/screens/match_detail_screen.dart';
import '../../features/match/presentation/screens/my_matches_screen.dart';
import '../../features/profile/presentation/screens/incoming_swap_list_screen.dart';
import '../../features/profile/presentation/screens/incoming_swap_offer_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/choose_plan_screen.dart';
import '../../features/subscription/presentation/screens/my_subscription_screen.dart';
import '../../features/subscription/presentation/screens/payment_confirmation_screen.dart';
import '../../features/subscription/presentation/screens/payment_method_screen.dart';
import '../../features/subscription/presentation/screens/subscription_upgrade_screen.dart';

class AppRouter {
  AppRouter._();

  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String checkEmail = '/check-email';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String incomingSwapOffers = '/incoming-swap-offers';

  static String incomingSwapOffer(String offerId, {bool reviewTitle = false}) {
    final path = '/incoming-swap-offers/$offerId';
    if (reviewTitle) return '$path?title=review';
    return path;
  }
  static const String chatConversation = '/chat/:threadId';
  static const String itemDetail = '/item/:itemId';
  static const String proposeSwap = '/propose-swap';
  static const String swapInvitationSent = '/propose-swap/sent';
  static const String addItem = '/add-item';
  static const String addItemSuccess = '/add-item/success';
  static const String myItems = '/my-items';
  static const String myMatches = '/my-matches';
  static const String matchDetail = '/match/:matchId';
  static const String notifications = '/notifications';
  static const String swapCompleted = '/swap-completed';
  static const String reviews = '/reviews';
  static const String publicProfile = '/user/:username';
  static const String subscriptionUpgrade = '/subscription/upgrade';
  static const String choosePlan = '/subscription/choose-plan';
  static const String paymentMethod = '/subscription/payment-method';
  static const String paymentConfirmation = '/subscription/payment-confirmation';
  static const String mySubscription = '/subscription/my-subscription';

  static String publicUser(String username) => '/user/$username';

  static String item(String itemId) => '/item/$itemId';

  static String match(String matchId) => '/match/$matchId';

  static String chat(String threadId, {String? name}) {
    final base = '/chat/$threadId';
    if (name == null || name.isEmpty) return base;
    return '$base?name=${Uri.encodeComponent(name)}';
  }

  /// All registered paths (for smoke tests). Dynamic segments use sample values.
  static List<String> get allSmokeTestLocations => [
        login,
        register,
        forgotPassword,
        '$checkEmail?email=demo@swap.it',
        home,
        profile,
        settings,
        incomingSwapOffers,
        incomingSwapOffer('1'),
        chat('c1', name: 'Marcus Chen'),
        item('4'),
        '$proposeSwap?itemId=4',
        '$swapInvitationSent?offerIndex=0',
        addItem,
        addItemSuccess,
        myItems,
        myMatches,
        match('m1'),
        notifications,
        swapCompleted,
        reviews,
        publicUser('marcus_c'),
        subscriptionUpgrade,
        choosePlan,
        paymentMethod,
        paymentConfirmation,
        mySubscription,
      ];

  static bool _isPublicAuthRoute(String path) {
    return path == login ||
        path == register ||
        path == forgotPassword ||
        path == checkEmail;
  }

  static String? _authRedirect(BuildContext context, GoRouterState state) {
    final path = state.uri.path;
    final loggedIn = AuthSession.isLoggedIn;

    if (loggedIn) {
      if (path == login || path == register) return home;
      return null;
    }

    if (!_isPublicAuthRoute(path)) {
      return login;
    }
    return null;
  }

  static GoRouter createRouter({AuthRefreshListenable? refreshListenable}) {
    return GoRouter(
      initialLocation: AuthSession.isLoggedIn ? home : login,
      refreshListenable: refreshListenable,
      redirect: _authRedirect,
      routes: _routes,
      errorBuilder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    );
  }

  static final List<RouteBase> _routes = <RouteBase>[
      GoRoute(
        path: login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (BuildContext context, GoRouterState state) =>
            const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: checkEmail,
        builder: (BuildContext context, GoRouterState state) {
          final email = state.uri.queryParameters['email'] ?? 'alex.chen@example.com';
          return CheckEmailScreen(email: email);
        },
      ),
      GoRoute(
        path: home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: profile,
        builder: (BuildContext context, GoRouterState state) =>
            const ProfileScreen(),
      ),
      GoRoute(
        path: settings,
        builder: (BuildContext context, GoRouterState state) =>
            const SettingsScreen(),
      ),
      GoRoute(
        path: incomingSwapOffers,
        builder: (BuildContext context, GoRouterState state) =>
            const IncomingSwapListScreen(),
        routes: [
          GoRoute(
            path: ':offerId',
            builder: (BuildContext context, GoRouterState state) {
              final reviewTitle =
                  state.uri.queryParameters['title'] == 'review';
              return IncomingSwapOfferScreen(
                offerId: state.pathParameters['offerId'],
                useReviewTitle: reviewTitle,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/chat/:threadId',
        builder: (BuildContext context, GoRouterState state) {
          return ChatConversationScreen(
            threadId: state.pathParameters['threadId'],
            partnerName: state.uri.queryParameters['name'],
          );
        },
      ),
      GoRoute(
        path: '/item/:itemId',
        builder: (BuildContext context, GoRouterState state) => ItemDetailScreen(
          itemId: state.pathParameters['itemId'],
        ),
      ),
      GoRoute(
        path: proposeSwap,
        builder: (BuildContext context, GoRouterState state) => ProposeSwapScreen(
          itemId: state.uri.queryParameters['itemId'],
        ),
      ),
      GoRoute(
        path: swapInvitationSent,
        builder: (BuildContext context, GoRouterState state) {
          final raw = state.uri.queryParameters['offerIndex'];
          final offerIndex = int.tryParse(raw ?? '') ?? 0;
          return SwapInvitationSentScreen(offerIndex: offerIndex);
        },
      ),
      GoRoute(
        path: addItem,
        builder: (BuildContext context, GoRouterState state) => const AddItemScreen(),
      ),
      GoRoute(
        path: addItemSuccess,
        builder: (BuildContext context, GoRouterState state) =>
            const AddItemSuccessScreen(),
      ),
      GoRoute(
        path: myItems,
        builder: (BuildContext context, GoRouterState state) => const MyItemsScreen(),
      ),
      GoRoute(
        path: myMatches,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: MatchStrings.myMatches,
              builder: () => const MyMatchesScreen(),
            ),
      ),
      GoRoute(
        path: '/match/:matchId',
        builder: (BuildContext context, GoRouterState state) => MatchDetailScreen(
          matchId: state.pathParameters['matchId'],
        ),
      ),
      GoRoute(
        path: notifications,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: ExtraStrings.notifications,
              builder: () => const NotificationsScreen(),
            ),
      ),
      GoRoute(
        path: swapCompleted,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: ExtraStrings.swapCompleted,
              builder: () => const SwapCompletedScreen(),
            ),
      ),
      GoRoute(
        path: reviews,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: ExtraStrings.reviewsTitle,
              builder: () => const ReviewsScreen(),
            ),
      ),
      GoRoute(
        path: '/user/:username',
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: ExtraStrings.publicProfileTitle,
              builder: () => PublicProfileScreen(
                username: state.pathParameters['username'],
              ),
            ),
      ),
      GoRoute(
        path: subscriptionUpgrade,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: SubscriptionStrings.subscriptionUpgradeTitle,
              builder: () => const SubscriptionUpgradeScreen(),
            ),
      ),
      GoRoute(
        path: choosePlan,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: SubscriptionStrings.choosePlanTitle,
              builder: () => const ChoosePlanScreen(),
            ),
      ),
      GoRoute(
        path: paymentMethod,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: SubscriptionStrings.paymentMethodTitle,
              builder: () => const PaymentMethodScreen(),
            ),
      ),
      GoRoute(
        path: paymentConfirmation,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: SubscriptionStrings.paymentConfirmationTitle,
              builder: () => const PaymentConfirmationScreen(),
            ),
      ),
      GoRoute(
        path: mySubscription,
        builder: (BuildContext context, GoRouterState state) =>
            gatedDesignBoardScreen(
              title: SubscriptionStrings.mySubscriptionTitle,
              builder: () => const MySubscriptionScreen(),
            ),
      ),
    ];
}

GoRouter createAppRouter({AuthRefreshListenable? refreshListenable}) =>
    AppRouter.createRouter(refreshListenable: refreshListenable);
