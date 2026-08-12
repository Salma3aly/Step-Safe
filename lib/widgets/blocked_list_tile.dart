import 'package:flutter/material.dart';
import '../models/blocked_item.dart';
import '../theme/app_theme.dart';

class BlockedListTile extends StatelessWidget {
  final BlockedItem item;
  final VoidCallback onTap;

  const BlockedListTile({super.key, required this.item, required this.onTap});

  Color get _riskColor {
    switch (item.risk) {
      case RiskLevel.high:
        return AppColors.danger;
      case RiskLevel.medium:
        return AppColors.warning;
      case RiskLevel.low:
        return AppColors.textSecondary;
    }
  }

  Color get _riskBg {
    switch (item.risk) {
      case RiskLevel.high:
        return AppColors.dangerLight;
      case RiskLevel.medium:
        return AppColors.warningLight;
      case RiskLevel.low:
        return const Color(0xFFEDEEEC);
    }
  }

  String get _riskLabel {
    switch (item.risk) {
      case RiskLevel.high:
        return 'High risk';
      case RiskLevel.medium:
        return 'Suspected';
      case RiskLevel.low:
        return 'Low risk';
    }
  }

  String? get _urgencyLabel {
    switch (item.urgency) {
      case UrgencyLevel.callNow:
        return 'Urgent Call Now';
      case UrgencyLevel.verifyAccount:
        return 'Verify Account';
      case UrgencyLevel.none:
        return null;
    }
  }

  String _timeAgo(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final icon = item.type == BlockedType.call ? Icons.call_outlined : Icons.sms_outlined;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _riskBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: _riskColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.sender,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _timeAgo(item.time),
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.reason,
                      style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                    ),
                    if (item.preview != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        item.preview!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textSecondary),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _riskBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _riskLabel,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _riskColor),
                          ),
                        ),
                        if (_urgencyLabel != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.dangerLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.warning_amber_rounded, size: 12, color: AppColors.danger),
                                const SizedBox(width: 4),
                                Text(
                                  _urgencyLabel!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.danger,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
