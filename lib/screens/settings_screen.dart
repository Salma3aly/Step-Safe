import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _callProtection = true;
  bool _smsProtection = true;
  bool _autoQuarantine = true;
  bool _trustedContactCall = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          const Text('Settings', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          _SectionCard(
            title: 'Protection',
            children: [
              _SwitchTile(
                title: 'Block spam calls',
                subtitle: 'Screen incoming calls against known spam patterns',
                value: _callProtection,
                onChanged: (v) => setState(() => _callProtection = v),
              ),
              _SwitchTile(
                title: 'Block spam SMS',
                subtitle: 'Scan messages on-device before you see them',
                value: _smsProtection,
                onChanged: (v) => setState(() => _smsProtection = v),
              ),
              _SwitchTile(
                title: 'Auto-quarantine high-risk messages',
                subtitle: 'Move high-confidence scams to a separate folder',
                value: _autoQuarantine,
                onChanged: (v) => setState(() => _autoQuarantine = v),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Family & trusted contacts',
            children: [
              _SwitchTile(
                title: 'Show "Call trusted contact" button',
                subtitle: 'Appears on warning screens for quick help',
                value: _trustedContactCall,
                onChanged: (v) => setState(() => _trustedContactCall = v),
              ),
              _NavTile(
                icon: Icons.person_add_alt_outlined,
                title: 'Manage trusted contacts',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Lists',
            children: [
              _NavTile(icon: Icons.block_outlined, title: 'Blocklist', onTap: () {}),
              _NavTile(icon: Icons.verified_outlined, title: 'Allowlist (never block)', onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'About',
            children: [
              _NavTile(icon: Icons.privacy_tip_outlined, title: 'Privacy — what stays on your device', onTap: () {}),
              _NavTile(icon: Icons.info_outline, title: 'How detection works', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 0.5),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
      value: value,
      onChanged: onChanged,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _NavTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
