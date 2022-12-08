import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final double? roundness;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final Widget? trailingWidget;
  final Function? onPressed;

  const AppButton({
    Key? key,
    this.label,
    this.roundness = 18,
    this.fontWeight = FontWeight.bold,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
    this.trailingWidget,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(roundness!),
            ),
          ),
          padding: MaterialStateProperty.all(padding!),
          backgroundColor: MaterialStateProperty.all(color5),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
              child: Text(
                label!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: fontWeight,
                ),
              ),
            ),
            if (trailingWidget != null)
              Positioned(
                top: 0,
                right: 25,
                child: trailingWidget!,
              )
          ],
        ),
        onPressed: () {
          if (onPressed != null) onPressed!();
        },
      ),
    );
  }
}
