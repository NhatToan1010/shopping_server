import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key, required this.title, required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSize.spaceBtwItems),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
