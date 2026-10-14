class IncomingSwapProposal {
  const IncomingSwapProposal({
    required this.id,
    required this.partnerName,
    required this.avatarUrl,
    required this.theyOfferTitle,
    required this.youGiveTitle,
    required this.theyOfferImageUrl,
    required this.youGiveImageUrl,
    required this.expiresLabel,
    required this.receivedLabel,
    this.isVerified = true,
  });

  final String id;
  final String partnerName;
  final String avatarUrl;
  final String theyOfferTitle;
  final String youGiveTitle;
  final String theyOfferImageUrl;
  final String youGiveImageUrl;
  final String expiresLabel;
  final String receivedLabel;
  final bool isVerified;
}
