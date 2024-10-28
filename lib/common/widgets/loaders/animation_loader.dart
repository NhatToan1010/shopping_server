import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class CustomAnimationLoader extends StatelessWidget {
  const CustomAnimationLoader(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed});

  final String text, animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.5), // Display Lottie animation
          const SizedBox(height: AppSize.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSize.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(backgroundColor: AppPallete.backgroundDark),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: AppPallete.backgroundLight),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
