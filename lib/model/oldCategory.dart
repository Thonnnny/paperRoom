import 'package:flutter/cupertino.dart';

class Category {
  const Category(this.icon, this.title, this.id);

  final String icon;
  final String title;
  final String id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        json["icon"],
        json["title"],
        json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
      };
}

final homeCategries = <Category>[
  const Category(
      'assets/icons/category_papers@2x.png', 'Papeleria', 'papeleria'),
  const Category(
      'assets/icons/category_planners@2x.png', 'Planners', 'planners'),
  const Category(
      'assets/icons/category_shirt@2x.png', 'Camisetas', 'camisetas'),
  const Category('assets/icons/category_gift@2x.png', 'Gift', 'gift'),
  const Category('assets/icons/category_agends@2x.png', 'Agendas', 'agendas'),
  const Category('assets/icons/category_wedding@2x.png', 'Wedding', 'wedding'),
  const Category('assets/icons/category_others@2x.png', 'Otros', 'otros'),
];
