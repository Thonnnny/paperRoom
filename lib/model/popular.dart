class PopularCategory {
  final String category;
  final String id;

  PopularCategory({this.category = '', this.id = ''});
}

class Product {
  final String title;
  final double star;
  final int sold;
  final double price;
  final String icon;
  final String id;
  Product(
      {this.title = '',
      this.star = 0.0,
      this.sold = 0,
      this.price = 0.0,
      this.icon = '',
      this.id = '0'});
}

final homePopularCategories = [
  PopularCategory(category: 'Todo', id: '1'),
  PopularCategory(category: 'Planificadores', id: '2'),
  PopularCategory(category: 'Camisetas', id: '3'),
  PopularCategory(category: 'Gift', id: '4'),
  PopularCategory(category: 'Agendas', id: '5'),
  PopularCategory(category: 'Bodas', id: '6'),
  PopularCategory(category: 'Otros', id: '7'),
];

final homePopularProducts = [
  Product(
    title: 'Planners',
    star: 4.5,
    sold: 8374,
    price: 120.00,
    icon: 'assets/icons/products/PaperRoom.png',
  ),
  Product(
    title: 'Small Bookcase',
    star: 4.7,
    sold: 7483,
    price: 145.40,
    icon: 'assets/icons/products/PaperRoom_2.png',
  ),
  Product(
    title: 'Camisetas',
    star: 4.3,
    sold: 6937,
    price: 40.00,
    icon: 'assets/icons/products/PaperRoom_3.png',
  ),
  Product(
    title: 'Agendas',
    star: 4.9,
    sold: 8174,
    price: 55.00,
    icon: 'assets/icons/products/PaperRoom_4.png',
  ),
  Product(
    title: 'Bolsas',
    star: 4.6,
    sold: 6843,
    price: 65.00,
    icon: 'assets/icons/products/PaperRoom_5.png',
  ),
  Product(
    title: 'Invitaciones',
    star: 4.5,
    sold: 7758,
    price: 69.00,
    icon: 'assets/icons/products/PaperRoom_6.png',
  ),
];
