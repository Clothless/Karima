import 'package:flutter/material.dart';
import 'package:karima/views/widgets/widgets.dart';

class CustomSocialMediaButton extends StatelessWidget {
  final String text;
  final Color background;
  final Color foureground;
  final String asset;
  final double fontsize;
  final Alignment alignment;
  final Function onPressed;

  const CustomSocialMediaButton({
    this.text = "",
    this.background = Colors.white,
    this.foureground = Colors.black,
    this.asset = "",
    this.fontsize = 16,
    this.alignment = Alignment.center,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
        )
      ),
      child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                backgroundColor: background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
                ),
                onPressed: () {
                  onPressed();
                },
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    Image.asset(
                      asset,
                      height: 40,
                      width: 40,
                      ),
                    const SizedBox(width: 30,),
                    CustomText(
                      text: text,
                      alignment: alignment,
                      color: foureground,
                      fontSize: fontsize,
                    ),
                  ],
                ),
              ),
    );
  }
}