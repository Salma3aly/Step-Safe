/// Simple in-memory models for the MVP interface.
/// No real detection logic yet â€” this is UI scaffolding with mock data
/// so the team can validate the UX before wiring up call/SMS interception.
library;

enum BlockedType { call, sms }

enum RiskLevel { low, medium, high }

/// Urgency flags surfaced to the user. These map to the "Call Now" /
/// "Verify Account" social-engineering prompts scammers push.
enum UrgencyLevel { none, callNow, verifyAccount }

class BlockedItem {
  final String id;
  final BlockedType type;
  final String sender;
  final String reason;
  final RiskLevel risk;
  final DateTime time;
  final String? preview;
  final UrgencyLevel urgency;

  const BlockedItem({
    required this.id,
    required this.type,
    required this.sender,
    required this.reason,
    required this.risk,
    required this.time,
    this.preview,
    this.urgency = UrgencyLevel.none,
  });
}

/// Lightweight social-engineering sniffing for the MVP.
/// Looks for the hallmark urgent hooks scammers use to rush a victim
/// ("call now", "verify your account", limited-time pressure, etc.).
/// Swap for a real NLP/ML classifier once detection is built.
UrgencyLevel detectUrgency({
  String? sender,
  String? reason,
  String? preview,
}) {
  final haystack = '${sender ?? ''} ${reason ?? ''} ${preview ?? ''}'.toLowerCase();

  const callNowMarkers = [
    'call now',
    'call immediately',
    'call this number',
    'call us now',
    'act now',
    'act immediately',
    'call today',
    'don\'t wait',
    'urgent call',
    'called you',
  ];
  const verifyMarkers = [
    'verify',
    'verification',
    'verify your account',
    'account suspended',
    'account locked',
    'confirm your',
    'confirm account',
    'reactivate',
    'update your account',
    'unusual activity',
    'security alert',
  ];

  for (final m in callNowMarkers) {
    if (haystack.contains(m)) return UrgencyLevel.callNow;
  }
  for (final m in verifyMarkers) {
    if (haystack.contains(m)) return UrgencyLevel.verifyAccount;
  }
  return UrgencyLevel.none;
}

/// Mock dataset â€” swap this for a real repository once detection is built.
final List<BlockedItem> mockBlockedItems = [
  BlockedItem(
    id: '1',
    type: BlockedType.call,
    sender: '+20 100 123 4567',
    reason: 'Reported robocall pattern',
    risk: RiskLevel.high,
    time: DateTime.now().subtract(const Duration(minutes: 12)),
    urgency: UrgencyLevel.callNow,
  ),
  BlockedItem(
    id: '2',
    type: BlockedType.sms,
    sender: 'Bank-Alert',
    reason: 'Impersonates a bank, contains a link',
    risk: RiskLevel.high,
    time: DateTime.now().subtract(const Duration(hours: 1)),
    preview: 'Your account is suspended. Verify now: bit.ly/3xk29',
    urgency: UrgencyLevel.verifyAccount,
  ),
  BlockedItem(
    id: '3',
    type: BlockedType.call,
    sender: '+20 111 987 6543',
    reason: 'High call frequency across users',
    risk: RiskLevel.medium,
    time: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  BlockedItem(
    id: '4',
    type: BlockedType.sms,
    sender: 'Unknown',
    reason: 'Prize / lottery scam pattern',
    risk: RiskLevel.medium,
    time: DateTime.now().subtract(const Duration(hours: 5)),
    preview: 'Congratulations! You won a prize. Claim here: tinyurl.com/9k2',
  ),
  BlockedItem(
    id: '5',
    type: BlockedType.call,
    sender: '+20 122 456 7890',
    reason: 'User-reported spam',
    risk: RiskLevel.low,
    time: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
