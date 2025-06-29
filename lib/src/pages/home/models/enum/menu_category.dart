enum MenuCategory {
  coffee(0, 'Coffee'),
  nonCoffee(1, 'Non Coffee'),
  pastry(2, 'Pastry');

  const MenuCategory(this.id, this.value);

  final int id;
  final String value;
}
