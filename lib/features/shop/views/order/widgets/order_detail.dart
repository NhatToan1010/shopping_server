import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/shop/models/order_model.dart';
import 'package:shopping_server/features/shop/views/cart/widgets/list_cart_item.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

import '../../../../../common/widgets/product_cart/carts/cart_item.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: Text('Order Detail'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: order.itemsPurchase.length,
          separatorBuilder: (context, index) {
            return const Column(
              children: [
                SizedBox(height: AppSize.small),
                Divider(),
                SizedBox(height: AppSize.small),
              ],
            );
          },
          itemBuilder: (context, index) => CartItem(
            cartItem: order.itemsPurchase[index],
          ),
        ),
      ),
    );
  }
}
