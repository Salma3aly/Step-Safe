import 'package:flutter/material.dart';
import '../models/blocked_item.dart';
import '../theme/app_theme.dart';
import '../widgets/blocked_list_tile.dart';
import 'report_screen.dart';

class BlockedScreen extends StatefulWidget {
  const BlockedScreen({super.key});

  @override
  State<BlockedScreen> createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  List<BlockedItem> get _calls =>
      mockBlockedItems.where((e) => e.type == BlockedType.call).toList();
  List<BlockedItem> get _sms =>
      mockBlockedItems.where((e) => e.type == BlockedType.sms).toList();

  void _openDetail(BlockedItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _BlockedDetailSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Blocked activity', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                IconButton(
                  icon: const Icon(Icons.flag_outlined),
                  tooltip: 'Report a number or message',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ReportScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'Calls'),
              Tab(text: 'Messages'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _BlockedList(items: _calls, onTap: _openDetail),
                _BlockedList(items: _sms, onTap: _openDetail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BlockedList extends StatelessWidget {
  final List<BlockedItem> items;
  final ValueChanged<BlockedItem> onTap;

  const _BlockedList({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('Nothing blocked yet', style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) => BlockedListTile(item: items[i], onTap: () => onTap(items[i])),
    );
  }
}

class _BlockedDetailSheet extends StatelessWidget {
  final BlockedItem item;

  const _BlockedDetailSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.sender, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Blocked because: ${item.reason}', style: const TextStyle(color: AppColors.textSecondary)),
          if (item.preview != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(item.preview!),
            ),
          ],
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('This was safe'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
                  child: const Text('Confirm spam'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
