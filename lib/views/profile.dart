import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:get/get.dart';

// Customer profile: personal info, delivery address, payment methods, settings.

const _mutedColor = Color(0xFF6B6872);

BoxDecoration _cardDecoration() =>
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16));

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFFF4F5F7),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: _cardDecoration(),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: primaryColor,
                  child: const Text(
                    'AO',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Gladwell Njuka',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Text(
                  'Customer since August 2026',
                  style: TextStyle(color: _mutedColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _section('Personal info', const [
            _InfoRow(Icons.mail_outline, 'Email', 'gladwell@gmail.com'),
            _InfoRow(Icons.phone_outlined, 'Phone', '+254 711 000 000'),
          ]),
          const SizedBox(height: 16),
          _section('Delivery address', const [
            _InfoRow(Icons.home_outlined, 'Home', 'Ngong Road, Nairobi'),
            _InfoRow(Icons.work_outline, 'Work', 'Westlands, Nairobi'),
          ]),
          const SizedBox(height: 16),
          _section('Payment methods', const [
            _InfoRow(Icons.phone_android, 'M-Pesa', '0711 ••• 000'),
            _InfoRow(Icons.credit_card, 'Visa', '•••• 4242'),
          ]),
          const SizedBox(height: 16),
          _section('Settings', const [
            _InfoRow(Icons.notifications_none, 'Order updates', 'On'),
            _InfoRow(Icons.lock_outline, 'Change password', ''),
          ]),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Get.offAllNamed('/'),
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              minimumSize: const Size.fromHeight(48),
              side: BorderSide(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...rows,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(icon, color: primaryColor),
      title: Text(label),
      trailing: Text(value, style: const TextStyle(color: _mutedColor)),
    );
  }
}
