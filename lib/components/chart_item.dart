import 'package:flutter/material.dart';
import 'package:freshbuyer/model/popular.dart';

import '../constants.dart';
import 'app_text.dart';
import 'item_counter.dart';

class ChartItemWidget extends StatefulWidget {
  const ChartItemWidget({Key? key, this.item}) : super(key: key);
  final Product? item;

  @override
  // ignore: library_private_types_in_public_api
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 110;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.item!.title,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color2,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                    text: widget.item!.price.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color2),
                const SizedBox(
                  height: 12,
                ),
                const Spacer(),
                ItemCounterWidget(
                  onAmountChanged: (newAmount) {
                    setState(() {
                      amount = newAmount;
                    });
                  },
                )
              ],
            ),
            Column(
              children: [
                const Icon(
                  Icons.close,
                  color: color3,
                  size: 25,
                ),
                const Spacer(
                  flex: 5,
                ),
                SizedBox(
                  width: 70,
                  child: AppText(
                    text: "\$${getPrice().toStringAsFixed(2)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.right,
                    color: color3,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 135,
      child: Image.asset(widget.item!.icon),
    );
  }

  double getPrice() {
    return widget.item!.price * amount;
  }
}
