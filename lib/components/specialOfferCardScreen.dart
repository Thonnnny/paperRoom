import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

class SpecialOfferCardWidget extends StatefulWidget {
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
  State<SpecialOfferCardWidget> createState() => _SpecialOfferCardWidgetState();
}

class _SpecialOfferCardWidgetState extends State<SpecialOfferCardWidget> {
  @override
  Widget build(BuildContext context) {
    bool? _isLoading = true;
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.height * 0.5,
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
                  Column(
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
                        "\$${widget.data['price'].toString()}",
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
                        "\$${widget.data['offerPrice'].toString()}",
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
                        width: size.width * 0.4,
                        child: Text(
                          widget.data['name'].toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: color5),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: size.width * 0.4,
                        child: Text(
                          widget.data['description'].toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                              color: color3),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.4,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              color: color5, //PARA PROBAR CONTAINER
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  widget.data['mainImage'].toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.data['mainImage'].toString(),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeOutDuration:
                                  const Duration(milliseconds: 500),
                              fit: BoxFit.cover,
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
