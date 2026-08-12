/// Simple in-memory models for the MVP interface.
/// No real detection logic yet — this is UI scaffolding with mock data
/// so the team can validate the UX before wiring up call/SMS interception.
library;

enum BlockedType { call, sms }

enum RiskLevel { low, medium, high }

class BlockedItem {
  final String id;
  final BlockedType type;
  final String sender;
  final String reason;
  final RiskLevel risk;
  final DateTime time;
  final String? preview;

  const BlockedItem({
    required this.id,
    required this.type,
    required this.sender,
    required this.reason,
    required this.risk,
    required this.time,
    this.preview,
  });
}

/// Mock dataset — swap this for a real repository once detection is built.
final List<BlockedItem> mockBlockedItems = [
  BlockedItem(
    id: '1',
    type: BlockedType.call,
    sender: '+20 100 123 4567',
    reason: 'Reported robocall pattern',
    risk: RiskLevel.high,
    time: DateTime.now().subtract(const Duration(minutes: 12)),
  ),
  BlockedItem(
    id: '2',
    type: BlockedType.sms,
    sender: 'Bank-Alert',
    reason: 'Impersonates a bank, contains a link',
    risk: RiskLevel.high,
    time: DateTime.now().subtract(const Duration(hours: 1)),
    preview: 'Your account is suspended. Verify now: bit.ly/3xk29',
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
