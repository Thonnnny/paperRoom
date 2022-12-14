import 'package:flutter/material.dart';

import 'package:freshbuyer/orders/details_order.dart';
import 'package:freshbuyer/size_config.dart';

import '../../constants.dart';
import '../../model/productElement.dart';

// ignore: must_be_immutable
class ShopDetailScreen extends StatefulWidget {
  final Product data;
  const ShopDetailScreen({
    super.key,
    required this.data,
  });
  static String route() => '/shop_detail';
  // ignore: prefer_typing_uninitialized_variables

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  late Product data;
  int _quantity = 0;
  int index = 0;
  bool _iscollected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: color3,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: getProportionateScreenHeight(428),
                    leading: IconButton(
                      icon: Image.asset(
                        'assets/icons/back@2x.png',
                        scale: 1,
                        color: color6,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: color4,
                        child: Image.network(
                          fit: BoxFit.fill,
                          widget.data.mainImage,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._buildTitle(),
                          const SizedBox(height: 16),
                          _buildLine(),
                          const SizedBox(height: 16),
                          ..._buildDescription(),
                          const SizedBox(height: 24),
                          _buildQuantity(),
                          const SizedBox(height: 115),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buldFloatBar()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTitle() {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.data.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 32, color: color2),
          ),
          IconButton(
            onPressed: () => setState(() => _iscollected = !_iscollected),
            icon: Image.asset(
              'assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png',
              color: color4,
            ),
            iconSize: 28,
          ),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: color4,
            ),
            child: const Text(
              '9,742 sold',
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w500, color: color3),
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/icons/start@2x.png',
            height: 20,
            width: 20,
            color: color1,
          ),
          const SizedBox(width: 8),
          const Text(
            '4.8 (6,573 reviews)',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: color5),
          ),
        ],
      ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: color5);
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Descripci??n',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color5)),
      const SizedBox(height: 8),
      Text(
        widget.data.description,
        style: const TextStyle(fontSize: 14, color: color2),
      ),
      // const ExpandableText(
      //   productElement['description'],
      //   style: TextStyle(fontSize: 14, color: color2),
      //   linkColor: color5,
      //   expandText: 'ver m??s',
      //   collapseText: 'ver menos',
      //   linkStyle: TextStyle(color: color5, fontWeight: FontWeight.bold),
      // ),
    ];
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        const Text('Cantidad',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: color5)),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: color4,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                InkWell(
                  child: Image.asset(
                    'assets/icons/detail/minus@2x.png',
                    scale: 2,
                    color: color6,
                  ),
                  onTap: () {
                    if (_quantity <= 0) return;
                    setState(() => _quantity -= 1);
                  },
                ),
                const SizedBox(width: 20),
                Text(widget.data.price.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: color2)),
                const SizedBox(width: 20),
                InkWell(
                  child: Image.asset(
                    'assets/icons/detail/plus@2x.png',
                    scale: 2,
                    color: color6,
                  ),
                  onTap: () => setState(() => _quantity += 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: getProportionateScreenWidth(258),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: color5,
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: color6,
              splashColor: color6,
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                  const SizedBox(width: 16),
                  const Text(
                    'Verifica tus datos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: color3,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Total price',
                        style: TextStyle(color: color2, fontSize: 12)),
                    SizedBox(height: 6),
                    Text('\$280.00',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: color6)),
                  ],
                ),
                buildAddCard()
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

// class ExpandableText extends StatefulWidget {
//   ExpandableText({this.text = ""});
//   //text is the total text of our expandable widget
//   final String text;
//   @override
//   _ExpandableTextState createState() => _ExpandableTextState();
// }

// class _ExpandableTextState extends State<ExpandableText> {
//   static const viewMore = ' view more...';
//   static const fixedLength = 50;
//   late String textToDisplay;
//   @override  
//   void initState() {
//     //if the text has more than a certain number of characters, the text we display will consist of that number of characters;
//     //if it's not longer we display all the text
//     print(widget.text.length);

//     //we arbitrarily chose 25 as the length
//     textToDisplay = widget.text.length > 25 ? widget.text.substring(0, 25) + viewMore : widget.text;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Text(textToDisplay),
//       onTap: () {
//         //if the text is not expanded we show it all
//         if (widget.text.length > 25 && textToDisplay.length <= (25 + viewMore.length)) {
//           setState(() {
//             textToDisplay = widget.text;
//           });
//         }
//         //else if the text is already expanded we contract it back
//         else if (widget.text.length > 25) {
//           setState(() {
//             textToDisplay = widget.text.substring(0, 25) + viewMore;
//           });
//         }
//       },
//     );
//   }
// }
