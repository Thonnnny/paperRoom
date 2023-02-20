import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

class SpecialOfferCardWidget extends StatelessWidget {
  const SpecialOfferCardWidget(
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
          Container(
            height: size.height * 0.4,
            width: size.width * 0.9,
            child: Card(
              color: color2,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red[800],
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
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green),
                        ),
                        const Divider(
                          color: color4,
                          thickness: 3,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            data['name'].toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: color5),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 150,
                          child: Text(
                            data['description'].toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                color: color3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.3,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              color: color5, //PARA PROBAR CONTAINER
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  data['mainImage'].toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
