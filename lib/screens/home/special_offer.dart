import 'package:flutter/material.dart';
import 'package:freshbuyer/components/special_offer_widget.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/oldCategory.dart';
import 'package:freshbuyer/model/special_offer.dart';
import 'package:freshbuyer/screens/mostpopular/most_popular_screen.dart';

typedef SpecialOffersOnTapSeeAll = void Function();

class SpecialOffers extends StatefulWidget {
  final SpecialOffersOnTapSeeAll? onTapSeeAll;
  const SpecialOffers({super.key, this.onTapSeeAll});

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late final List<Category> categories = homeCategries;
  late final List<SpecialOffer> specials = homeSpecialOffers;

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        const SizedBox(height: 24),
        Stack(children: [
          Container(
            height: 181,
            decoration: const BoxDecoration(
              color: color5,
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: PageView.builder(
              itemBuilder: (context, index) {
                final data = specials[index];
                return SpecialOfferWidget(context, data: data, index: index);
              },
              itemCount: specials.length,
              allowImplicitScrolling: true,
              onPageChanged: (value) {
                setState(() => selectIndex = value);
              },
            ),
          ),
          _buildPageIndicator()
        ]),
        const SizedBox(height: 24),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 100,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            maxCrossAxisExtent: 77,
          ),
          itemBuilder: ((context, index) {
            final data = categories[index];
            return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, MostPopularScreen.route()),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: color5,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        data.icon,
                        width: 35,
                        height: 35,
                        color: color3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FittedBox(
                    child: Text(
                      data.title,
                      style: const TextStyle(
                          color: color2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Ofertas especiales',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: color2),
        ),
        TextButton(
          onPressed: () => widget.onTapSeeAll?.call(),
          child: const Text(
            'Ver Todo',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: color6),
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < specials.length; i++) {
      list.add(i == selectIndex ? _indicator(true) : _indicator(false));
    }
    return Container(
      height: 181,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 4.0,
        width: isActive ? 16 : 4.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          color: isActive ? color6 : color2,
        ),
      ),
    );
  }
}
