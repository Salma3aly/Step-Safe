import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _numberController = TextEditingController();
  final _detailsController = TextEditingController();
  String _reportType = 'Call';
  bool _submitted = false;

  @override
  void dispose() {
    _numberController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_numberController.text.trim().isEmpty) return;
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report spam')),
      body: SafeArea(
        child: _submitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.primary, size: 56),
            const SizedBox(height: 16),
            const Text(
              'Thanks — this helps protect other users too',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Reporting a number or message adds it to the shared spam database used by all users.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13.5),
        ),
        const SizedBox(height: 20),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'Call', label: Text('Phone call'), icon: Icon(Icons.call_outlined)),
            ButtonSegment(value: 'SMS', label: Text('Text message'), icon: Icon(Icons.sms_outlined)),
          ],
          selected: {_reportType},
          onSelectionChanged: (s) => setState(() => _reportType = s.first),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _numberController,
          decoration: InputDecoration(
            labelText: _reportType == 'Call' ? 'Phone number' : 'Sender / phone number',
            hintText: '+20 1XX XXX XXXX',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _detailsController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'What happened? (optional)',
            hintText: 'e.g. Claimed to be my bank and asked for a code',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _submit,
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            child: const Text('Submit report'),
          ),
        ),
      ],
    );
  }
}
