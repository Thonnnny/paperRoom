import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

import '../components/app_button.dart';
import '../components/app_text.dart';

class CheckoutBottomSheet extends StatefulWidget {
  const CheckoutBottomSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: const BoxDecoration(
          color: color3,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      // ignore: unnecessary_new
      child: new Wrap(
        children: <Widget>[
          Row(
            children: [
              const AppText(
                text: "Información del Pedido",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: color5,
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 25,
                    color: color2,
                  ))
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          getDivider(),
          checkoutRow("Delivery", trailingText: "Selecciona Metodo"),
          getDivider(),
          checkoutRow("Pago",
              trailingWidget:
                  const Icon(Icons.payment, color: color3, size: 30)),
          getDivider(),
          checkoutRow("Codigo de promoción", trailingText: "Sin descuento"),
          getDivider(),
          checkoutRow("Total", trailingText: "\$133.97"),
          getDivider(),
          const SizedBox(
            height: 30,
          ),
          termsAndConditionsAgreement(context),
          Container(
            margin: const EdgeInsets.only(
              top: 25,
            ),
            child: AppButton(
              label: "Pedir Orden",
              fontWeight: FontWeight.w600,
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              onPressed: () {
                onPlaceOrderClicked();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getDivider() {
    return const Divider(
      thickness: 1,
      color: color4,
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: const TextSpan(
          text: 'Al realizar un pedido, usted acepta nuestros',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            //fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
                text: " Terminos",
                style: TextStyle(color: color5, fontWeight: FontWeight.bold)),
            TextSpan(text: " Y"),
            TextSpan(
                text: " Condiciones",
                style: TextStyle(color: color5, fontWeight: FontWeight.bold)),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          AppText(
            text: label,
            fontSize: 18,
            color: color2,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          if (trailingText == null)
            trailingWidget!
          else
            AppText(
              text: trailingText,
              fontSize: 16,
              color: color4,
              fontWeight: FontWeight.w600,
            ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: color4,
          )
        ],
      ),
    );
  }

  void onPlaceOrderClicked() {
    Navigator.pop(context);
    //showDialog(context: context, child: OrderFailedDialogue());
  }
}
