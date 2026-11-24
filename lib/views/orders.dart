import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

// Customer's own order history with a simple delivery tracker.

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

class _Order {
  final String id;
  final String items;
  final double total;
  final String status; // Processing, Shipped, Delivered, Cancelled
  final String date;
  const _Order(this.id, this.items, this.total, this.status, this.date);
}

const _filters = ['All', 'In progress', 'Delivered', 'Cancelled'];

const _orders = <_Order>[
  _Order(
    '#1048',
    '1 × Solitaire Diamond Ring',
    1850.00,
    'Processing',
    'Nov 11',
  ),
  _Order('#1041', '1 × Gold Hoop Earrings', 310.00, 'Shipped', 'Nov 8'),
  _Order('#1030', '1 × Pearl Strand Necklace', 960.00, 'Delivered', 'Oct 20'),
  _Order(
    '#1022',
    '1 × Rose Gold Band, 1 × Silver Charm Bracelet',
    610.00,
    'Delivered',
    'Sep 14',
  ),
  _Order('#1015', '1 × Sapphire Studs', 780.00, 'Cancelled', 'Aug 30'),
];

Color _statusColor(String status) {
  switch (status) {
    case 'Processing':
      return const Color(0xFFB7791F);
    case 'Shipped':
      return const Color(0xFF2B6CB0);
    case 'Delivered':
      return const Color(0xFF2F855A);
    default:
      return const Color(0xFFC53030);
  }
}

bool _matches(_Order o, String filter) {
  switch (filter) {
    case 'In progress':
      return o.status == 'Processing' || o.status == 'Shipped';
    case 'Delivered':
      return o.status == 'Delivered';
    case 'Cancelled':
      return o.status == 'Cancelled';
    default:
      return true;
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final visible = _orders.where((o) => _matches(o, _filter)).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('My orders'),
        backgroundColor: const Color(0xFFF4F5F7),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final f = _filters[i];
                final selected = _filter == f;
                return ChoiceChip(
                  label: Text(f),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = f),
                  selectedColor: primaryColor,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                  ),
                  showCheckmark: false,
                  backgroundColor: Colors.white,
                  side: BorderSide.none,
                );
              },
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text(
                      'You have no orders here yet.',
                      style: TextStyle(color: _mutedColor),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _OrderTile(order: visible[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final _Order order;
  const _OrderTile({required this.order});

  int get _step {
    switch (order.status) {
      case 'Processing':
        return 0;
      case 'Shipped':
        return 1;
      case 'Delivered':
        return 2;
      default:
        return -1; // cancelled: no tracker
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(order.status);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Order ${order.id}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8),
              Text(
                order.date,
                style: const TextStyle(color: _mutedColor, fontSize: 12),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            order.items,
            style: const TextStyle(color: _mutedColor, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            _money(order.total),
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          if (_step >= 0) ...[
            const SizedBox(height: 14),
            _Tracker(step: _step),
          ],
        ],
      ),
    );
  }
}

class _Tracker extends StatelessWidget {
  final int step; // 0 ordered, 1 shipped, 2 delivered
  const _Tracker({required this.step});

  static const _labels = ['Ordered', 'Shipped', 'Delivered'];

  @override
  Widget build(BuildContext context) {
    final inactive = Colors.grey.shade300;
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < _labels.length; i++) ...[
              if (i > 0)
                Expanded(
                  child: Container(
                    height: 2,
                    color: i <= step ? primaryColor : inactive,
                  ),
                ),
              Icon(
                i <= step ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 20,
                color: i <= step ? primaryColor : Colors.grey.shade400,
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final l in _labels)
              Text(l, style: const TextStyle(fontSize: 11, color: _mutedColor)),
          ],
        ),
      ],
    );
  }
}
