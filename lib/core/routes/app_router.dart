import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
import '../../features/extra/presentation/screens/notifications_screen.dart';
import '../../features/extra/presentation/screens/public_profile_screen.dart';
import '../../features/extra/presentation/screens/reviews_screen.dart';
import '../../features/extra/presentation/screens/swap_completed_screen.dart';
import '../../features/match/presentation/screens/match_detail_screen.dart';
import '../../features/match/presentation/screens/my_matches_screen.dart';
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
  static const String incomingSwapOffer = '/incoming-swap-offer';
  static const String chatConversation = '/chat/:threadId';
  static const String itemDetail = '/item/:itemId';
  static const String proposeSwap = '/propose-swap';
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
        incomingSwapOffer,
        chat('c1', name: 'Marcus Chen'),
        item('4'),
        '$proposeSwap?itemId=4',
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

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: <RouteBase>[
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
        path: incomingSwapOffer,
        builder: (BuildContext context, GoRouterState state) =>
            const IncomingSwapOfferScreen(),
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
        builder: (BuildContext context, GoRouterState state) => const MyMatchesScreen(),
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
            const NotificationsScreen(),
      ),
      GoRoute(
        path: swapCompleted,
        builder: (BuildContext context, GoRouterState state) =>
            const SwapCompletedScreen(),
      ),
      GoRoute(
        path: reviews,
        builder: (BuildContext context, GoRouterState state) => const ReviewsScreen(),
      ),
      GoRoute(
        path: '/user/:username',
        builder: (BuildContext context, GoRouterState state) => PublicProfileScreen(
          username: state.pathParameters['username'],
        ),
      ),
      GoRoute(
        path: subscriptionUpgrade,
        builder: (BuildContext context, GoRouterState state) =>
            const SubscriptionUpgradeScreen(),
      ),
      GoRoute(
        path: choosePlan,
        builder: (BuildContext context, GoRouterState state) => const ChoosePlanScreen(),
      ),
      GoRoute(
        path: paymentMethod,
        builder: (BuildContext context, GoRouterState state) => const PaymentMethodScreen(),
      ),
      GoRoute(
        path: paymentConfirmation,
        builder: (BuildContext context, GoRouterState state) =>
            const PaymentConfirmationScreen(),
      ),
      GoRoute(
        path: mySubscription,
        builder: (BuildContext context, GoRouterState state) => const MySubscriptionScreen(),
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) =>
        const LoginScreen(),
  );
}
