import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/shop/controllers/products/order_controller.dart';
import 'package:shopping_server/features/shop/views/order/widgets/list_order_widget.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      // ----- AppBar
      appBar: const CustomAppbar(title: Text('My Orders'), showBackArrow: true),

      // ----- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: FutureBuilder(
            future: controller.getAllUserOrder(),
            builder: (context, snapshot) {
              final response = CloudHelperFunctions.checkMultipleStateRecord(snapshot: snapshot);
              if (response != null) return response;

              final orders = snapshot.data!;

              return ListView.separated(
                shrinkWrap: true,
                itemCount: orders.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSize.medium),
                itemBuilder: (context, index) => ListOrderWidget(order: orders[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
