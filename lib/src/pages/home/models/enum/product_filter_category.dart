import 'package:flutter/material.dart';

enum ProductFilterCategory {
  rating(
    id: 0,
    label: 'Rating 4.5+',
    icon: Icons.star_border_purple500_rounded,
  ),
  price(id: 1, label: 'Price', icon: Icons.attach_money_outlined),
  discount(id: 2, label: 'Discount', icon: Icons.percent);

  const ProductFilterCategory({
    required this.id,
    required this.label,
    required this.icon,
  });

  final int id;
  final String label;
  final IconData icon;
}
