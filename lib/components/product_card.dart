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
      hoverColor: color1,
      borderRadius: borderRadius,
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => SafeArea(
                        child: ShopDetailScreen(
                      product: widget.data,
                    ))),
            (Route<dynamic> route) => false);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: borderRadius,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Image.network('${widget.data.mainImage}',
                          width: 150, height: 150, fit: BoxFit.cover)),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () =>
                        setState(() => _iscollected = !_iscollected),
                    icon: Image.asset(
                        'assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png',
                        color: color6),
                    iconSize: 28,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width * 0.5,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: size.width,
                  height: size.height * 0.085,
                  child: Text(
                    '${widget.data.name.split('').first.toUpperCase() + widget.data.name.split('').sublist(1).join('')}',
                    //overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildSoldPoint(4.5, 6937),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${widget.data.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: color2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Envios por el país',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: color6),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '|',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: color6,
                          fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Entrega 24h',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: color6),
                    ),
                  ],
                ),
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
