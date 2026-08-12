import 'package:flutter/material.dart';
import '../models/blocked_item.dart';
import '../theme/app_theme.dart';
import '../widgets/blocked_list_tile.dart';
import '../widgets/stat_card.dart';
import 'blocked_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _callProtection = true;
  bool _smsProtection = true;

  bool get _isProtected => _callProtection && _smsProtection;

  @override
  Widget build(BuildContext context) {
    final recent = mockBlockedItems.take(3).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.jpeg',
                height: 42,
                width: 42,
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: _ProtectionStatusCard(
                isProtected: _isProtected,
                callProtection: _callProtection,
                smsProtection: _smsProtection,
                onCallChanged: (v) => setState(() => _callProtection = v),
                onSmsChanged: (v) => setState(() => _smsProtection = v),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: const [
                  Expanded(
                    child: StatCard(
                      value: '18',
                      label: 'Blocked this week',
                      icon: Icons.block,
                      color: AppColors.danger,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      value: '3',
                      label: 'Reviewed by you',
                      icon: Icons.fact_check_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recent activity', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const BlockedScreen()),
                      );
                    },
                    child: const Text('See all'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            sliver: SliverList.separated(
              itemCount: recent.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) => BlockedListTile(item: recent[i], onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProtectionStatusCard extends StatelessWidget {
  final bool isProtected;
  final bool callProtection;
  final bool smsProtection;
  final ValueChanged<bool> onCallChanged;
  final ValueChanged<bool> onSmsChanged;

  const _ProtectionStatusCard({
    required this.isProtected,
    required this.callProtection,
    required this.smsProtection,
    required this.onCallChanged,
    required this.onSmsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isProtected ? Icons.verified_user : Icons.gpp_maybe_outlined,
                  color: isProtected ? AppColors.primary : AppColors.warning,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  isProtected ? 'You are protected' : 'Protection partially off',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Divider(height: 28),
            _ToggleRow(
              icon: Icons.call_outlined,
              label: 'Block spam calls',
              value: callProtection,
              onChanged: onCallChanged,
            ),
            const SizedBox(height: 10),
            _ToggleRow(
              icon: Icons.sms_outlined,
              label: 'Block spam SMS',
              value: smsProtection,
              onChanged: onSmsChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
