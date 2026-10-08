enum ChatMessageType { incoming, outgoing, safeSpot }

class ChatMessage {
  const ChatMessage({
    required this.type,
    this.text,
    this.time,
  });

  final ChatMessageType type;
  final String? text;
  final String? time;
}
