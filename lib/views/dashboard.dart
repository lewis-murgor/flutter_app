import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

// Customer home: greeting, promo, categories, new arrivals, latest order.

const _mutedColor = Color(0xFF6B6872);

BoxDecoration _cardDecoration() =>
    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16));

/// 1850 -> $1,850.00
String _money(double v) {
  final parts = v.toStringAsFixed(2).split('.');
  final whole = parts[0].replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  return '\$$whole.${parts[1]}';
}

class _Item {
  final String name;
  final double price;
  final IconData icon;
  final Color tint;
  const _Item(this.name, this.price, this.icon, this.tint);
}

const _newArrivals = <_Item>[
  _Item('Emerald Pendant', 1290.00, Icons.auto_awesome, Color(0xFFD9EBE1)),
  _Item('Sapphire Studs', 780.00, Icons.star_outline, Color(0xFFD8E0F3)),
  _Item('Tennis Bracelet', 2400.00, Icons.all_inclusive, Color(0xFFE6E3EC)),
  _Item('Rose Gold Band', 420.00, Icons.circle_outlined, Color(0xFFF3DDD8)),
];

class _CategoryTile {
  final String label;
  final IconData icon;
  const _CategoryTile(this.label, this.icon);
}

const _categoryTiles = <_CategoryTile>[
  _CategoryTile('Rings', Icons.diamond_outlined),
  _CategoryTile('Necklaces', Icons.auto_awesome),
  _CategoryTile('Earrings', Icons.star_outline),
  _CategoryTile('Bracelets', Icons.all_inclusive),
];

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Hello, Gladwell!'),
        backgroundColor: const Color(0xFFF4F5F7),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          // Promo banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Winter collection',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'New gold and pearl pieces, handmade in small batches.',
                        style: TextStyle(color: Colors.white70, height: 1.4),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.diamond, size: 56, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Categories
          const Text(
            'Shop by category',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            children: _categoryTiles.map((c) {
              return Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Icon(c.icon, color: primaryColor),
                    ),
                    const SizedBox(height: 6),
                    Text(c.label, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // New arrivals
          const Text(
            'New arrivals',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _newArrivals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => _ArrivalCard(item: _newArrivals[i]),
            ),
          ),
          const SizedBox(height: 24),

          // Latest order
          const Text(
            'Your latest order',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE3E8F2),
                  child: Icon(
                    Icons.local_shipping_outlined,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Solitaire Diamond Ring',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Order #1048, being prepared',
                        style: TextStyle(color: _mutedColor, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Text(
                  _money(1850.00),
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrivalCard extends StatelessWidget {
  final _Item item;
  const _ArrivalCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: item.tint,
              child: Icon(item.icon, size: 44, color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  _money(item.price),
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
