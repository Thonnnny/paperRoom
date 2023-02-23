import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/productsInOffer.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget(
    this.context, {
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final dynamic data;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Precio anterior:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: color6,
                  ),
                ),
                Text(
                  "\$${data['price'].toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: color6,
                      decoration: TextDecoration.lineThrough),
                ),
                const Text(
                  "Precio en oferta:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: color6,
                  ),
                ),
                Text(
                  "\$${data['offerPrice'].toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: color6),
                ),
                const SizedBox(height: 12),
                Text(
                  data['name'].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, color: color5),
                ),
                _buildLine(),
                const SizedBox(height: 12),
                Text(
                  data['description'].toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 12, color: color2),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: size.height * 0.4,
            width: size.width * 0.4,
            decoration: BoxDecoration(
              color: color5, //PARA PROBAR CONTAINER
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  data['mainImage'].toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: data['mainImage'].toString(),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fadeInDuration: const Duration(milliseconds: 500),
              fadeOutDuration: const Duration(milliseconds: 500),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine() {
    return Container(height: 1, color: color5);
  }
}
