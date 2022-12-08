import 'package:flutter/cupertino.dart';
import 'package:freshbuyer/constants.dart';

import '../model/special_offer.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget(
    this.context, {
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final SpecialOffer data;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.discount,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 40, color: color6),
                ),
                const SizedBox(height: 12),
                Text(
                  data.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18, color: color2),
                ),
                const SizedBox(height: 12),
                Text(
                  data.detail,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12, color: color2),
                ),
              ],
            ),
          ),
        ),
        Image.asset(data.icon),
      ],
    );
  }
}
