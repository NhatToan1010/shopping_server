import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/circle_image.dart';
import '../../texts/product_text/product_brand_text.dart';
import '../../texts/product_text/product_title_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key, required this.cartItem,
  });

  final CartModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ----- Image
        CircleImage(
          imageUrl: cartItem.image ?? '',
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(AppSize.extraSmall),
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? AppPallete.darkGrey
              : AppPallete.greyColor,
        ),
        const SizedBox(width: AppSize.spaceBtwItems),

        // ----- Title, Price, Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: ProductTitle(title: cartItem.productName, maxLines: 1, smallSize: false,)),
              ProductBrandText(brandName: cartItem.brandName!),

              // ----- Attribute
              if (cartItem.variationId != '')
                Text.rich(TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries.map((item) => TextSpan(
                    children: [
                      TextSpan(text: '${item.key} ', style: Theme.of(context).textTheme.labelMedium),
                      TextSpan(text: '${item.value} ', style: Theme.of(context).textTheme.bodyMedium),
                    ]
                  )).toList()
                ))
            ],
          ),
        )
      ],
    );
  }
}
