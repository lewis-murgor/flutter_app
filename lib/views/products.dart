import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';

// Customer shop: browse by category, favourite items, view details, add to cart.

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

class _Product {
  final String name;
  final String category;
  final double price;
  final String description;
  final IconData icon;
  final Color tint;
  const _Product(
    this.name,
    this.category,
    this.price,
    this.description,
    this.icon,
    this.tint,
  );
}

const _categories = ['All', 'Rings', 'Necklaces', 'Earrings', 'Bracelets'];

const _products = <_Product>[
  _Product(
    'Solitaire Diamond Ring',
    'Rings',
    1850.00,
    '18k white gold band with a 0.75 ct round diamond.',
    Icons.diamond_outlined,
    Color(0xFFE3E8F2),
  ),
  _Product(
    'Rose Gold Band',
    'Rings',
    420.00,
    'Slim 14k rose gold band with a polished finish.',
    Icons.circle_outlined,
    Color(0xFFF3DDD8),
  ),
  _Product(
    'Pearl Strand Necklace',
    'Necklaces',
    960.00,
    'Freshwater pearls on a hand-knotted silk strand, 45 cm.',
    Icons.blur_circular,
    Color(0xFFEDEAE2),
  ),
  _Product(
    'Emerald Pendant',
    'Necklaces',
    1290.00,
    'Oval emerald in a gold setting on a fine 18k chain.',
    Icons.auto_awesome,
    Color(0xFFD9EBE1),
  ),
  _Product(
    'Gold Hoop Earrings',
    'Earrings',
    310.00,
    'Lightweight 14k gold hoops, 25 mm.',
    Icons.radio_button_unchecked,
    Color(0xFFF1E6C9),
  ),
  _Product(
    'Sapphire Studs',
    'Earrings',
    780.00,
    'Blue sapphire studs with secure screw backs.',
    Icons.star_outline,
    Color(0xFFD8E0F3),
  ),
  _Product(
    'Tennis Bracelet',
    'Bracelets',
    2400.00,
    'A line of brilliant-cut diamonds set in white gold.',
    Icons.all_inclusive,
    Color(0xFFE6E3EC),
  ),
  _Product(
    'Silver Charm Bracelet',
    'Bracelets',
    190.00,
    'Sterling silver chain with three starter charms.',
    Icons.favorite_border,
    Color(0xFFE9EBEE),
  ),
];

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String _selected = 'All';
  final Set<String> _favourites = {};

  void _toggleFavourite(String name) {
    setState(() {
      if (!_favourites.remove(name)) _favourites.add(name);
    });
  }

  void _showDetails(_Product p) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: p.tint,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(p.icon, size: 64, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              Text(
                p.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(p.category, style: const TextStyle(color: _mutedColor)),
              const SizedBox(height: 12),
              Text(p.description, style: const TextStyle(height: 1.4)),
              const SizedBox(height: 12),
              Text(
                _money(p.price),
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${p.name} added to cart')),
                  );
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Add to cart'),
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = _selected == 'All'
        ? _products
        : _products.where((p) => p.category == _selected).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Shop'),
        backgroundColor: const Color(0xFFF4F5F7),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final c = _categories[i];
                final selected = _selected == c;
                return ChoiceChip(
                  label: Text(c),
                  selected: selected,
                  onSelected: (_) => setState(() => _selected = c),
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
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: visible.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.74,
              ),
              itemBuilder: (_, i) {
                final p = visible[i];
                return _ProductCard(
                  product: p,
                  isFavourite: _favourites.contains(p.name),
                  onTap: () => _showDetails(p),
                  onFavourite: () => _toggleFavourite(p.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final _Product product;
  final bool isFavourite;
  final VoidCallback onTap;
  final VoidCallback onFavourite;

  const _ProductCard({
    required this.product,
    required this.isFavourite,
    required this.onTap,
    required this.onFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _cardDecoration(),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: product.tint,
                    child: Icon(product.icon, size: 54, color: Colors.black54),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      onPressed: onFavourite,
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: isFavourite ? primaryColor : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.category,
                    style: const TextStyle(color: _mutedColor, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _money(product.price),
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
      ),
    );
  }
}
