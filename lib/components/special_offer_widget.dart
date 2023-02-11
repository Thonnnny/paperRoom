import 'package:flutter/cupertino.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/productsInOffer.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget(
    this.context, {
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final Offer data;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                  "\$${data.price.toString()}",
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
                  "\$${data.offerPrice.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: color6),
                ),
                const SizedBox(height: 12),
                Text(
                  data.name.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, color: color5),
                ),
                _buildLine(),
                const SizedBox(height: 12),
                Text(
                  data.description.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 12, color: color2),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: 180.0,
            width: 180.0,
            decoration: BoxDecoration(
              color: color5, //PARA PROBAR CONTAINER
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(
                  data.mainImage.toString(),
                ),
                fit: BoxFit.cover,
              ),
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
