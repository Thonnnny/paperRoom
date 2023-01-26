import 'package:flutter/material.dart';
import 'package:freshbuyer/model/productElement.dart';

import '../constants.dart';
import '../screens/detail/detail_screen.dart';

typedef ProductCardOnTaped = void Function(Product data);

bool _iscollected = false;

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.data, this.ontap});

  final Product data;
  final ProductCardOnTaped? ontap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return InkWell(
      hoverColor: color4,
      borderRadius: borderRadius,
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: borderRadius,
              color: color5,
            ),
            child: Stack(
              children: [
                Container(
                    child: Image.network('${widget.data.mainImage}',
                        width: 150, height: 150, fit: BoxFit.cover)),
                Positioned(
                  child: IconButton(
                    onPressed: () =>
                        setState(() => _iscollected = !_iscollected),
                    icon: Image.asset(
                        'assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png',
                        color: color2),
                    iconSize: 28,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width * 0.5,
            height: size.height * 0.2,
            child: Column(
              children: [
                const SizedBox(height: 12),
                FittedBox(
                  child: Text(
                    '${widget.data.name.split('').first.toUpperCase()}' +
                        '${widget.data.name.split('').sublist(1).join('')}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: color6,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildSoldPoint(4.5, 6937),
                const SizedBox(height: 10),
                Text(
                  '\$${widget.data.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: color2),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSoldPoint(double star, int sold) {
    return Row(
      children: [
        Image.asset('assets/icons/start@2x.png',
            width: 20, height: 20, color: color6),
        const SizedBox(width: 8),
        Text(
          '$star',
          style: const TextStyle(
            color: color3,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '|',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: color6, fontSize: 14),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color2.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            '$sold Vendidos',
            style: const TextStyle(
              color: Color(0xFF35383F),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
