import 'package:flutter/material.dart';
import 'package:shopping_server/common/styles/spacing_styles.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onPressed,
  });

  final String title, subtitle, image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyles.paddingWithAppbarHeight * 2,
          child: Column(
            children: [
              // Image
              Image(
                width: 300,
                image: AssetImage(image),
              ),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Title and Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceBtwItems),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(LocalTexts.done),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
