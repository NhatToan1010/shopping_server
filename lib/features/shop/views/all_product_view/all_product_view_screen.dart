import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/shop/controllers/products/all_product_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/product_cart/sortable/sortable_product.dart';
import '../../models/products/product_model.dart';

class AllProductViewScreen extends StatelessWidget {
  const AllProductViewScreen({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());

    return Scaffold(
      // ----- AppBar
      appBar:
          const CustomAppbar(title: Text('All Product'), showBackArrow: true),

      // ----- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                // --- Check states of FutureBuilder snapshot
                final widget = CloudHelperFunctions.checkMultipleStateRecord(snapshot: snapshot);
                if (widget != null) return widget;

                // --- If products found
                final products = snapshot.data!;
                return SortableProduct(products: products);
              }),
        ),
      ),
    );
  }
}
