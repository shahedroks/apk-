import '../../../../core/constants/profile_strings.dart';
import '../domain/incoming_swap_proposal.dart';

class IncomingSwapMockData {
  IncomingSwapMockData._();

  static const List<IncomingSwapProposal> proposals = [
    IncomingSwapProposal(
      id: '1',
      partnerName: 'Marcus Chen',
      avatarUrl: ProfileStrings.profileAvatarUrl,
      theyOfferTitle: 'Audio-Technica LP60X Turntable',
      youGiveTitle: 'Keychron Q1 Pro Mechanical Keyboard',
      theyOfferImageUrl: ProfileStrings.offerTurntableImageUrl,
      youGiveImageUrl: ProfileStrings.offerKeyboardImageUrl,
      expiresLabel: 'Expires 47h 46m',
      receivedLabel: 'Received 14 minutes ago',
    ),
    IncomingSwapProposal(
      id: '2',
      partnerName: 'Elena Rostova',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      theyOfferTitle: 'Ceramic Tea Set (6 pieces)',
      youGiveTitle: 'Monstera Deliciosa Plant',
      theyOfferImageUrl:
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=400&fit=crop',
      youGiveImageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400&h=400&fit=crop',
      expiresLabel: 'Expires 2d 5h',
      receivedLabel: 'Received 3 hours ago',
    ),
    IncomingSwapProposal(
      id: '3',
      partnerName: 'David Kim',
      avatarUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop',
      theyOfferTitle: 'Custom Mech Keyboard',
      youGiveTitle: 'Vintage Film Camera',
      theyOfferImageUrl: ProfileStrings.offerKeyboardImageUrl,
      youGiveImageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=400&fit=crop',
      expiresLabel: 'Expires 5d 12h',
      receivedLabel: 'Received yesterday',
    ),
  ];

  static IncomingSwapProposal? byId(String id) {
    for (final p in proposals) {
      if (p.id == id) return p;
    }
    return null;
  }
}
