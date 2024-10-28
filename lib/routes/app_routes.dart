import 'package:get/get.dart';
import 'package:shopping_server/features/personalization/views/setting/setting_screen.dart';
import 'package:shopping_server/features/shop/views/all_brand_view/all_brand_view_screen.dart';
import 'package:shopping_server/features/shop/views/cart/cart_screen.dart';
import 'package:shopping_server/features/shop/views/checkout/checkout_screen.dart';
import 'package:shopping_server/features/shop/views/home/home_screen.dart';
import 'package:shopping_server/features/shop/views/navigation_menu.dart';
import 'package:shopping_server/features/shop/views/order/my_order_screen.dart';
import 'package:shopping_server/features/shop/views/product_reviews/product_reviews_screen.dart';
import 'package:shopping_server/features/shop/views/wishlist/wishlist_screen.dart';
import 'package:shopping_server/routes/routes.dart';

import '../features/shop/views/store/store_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: LocalRoutes.home, page: () => const HomeScreen()),
    GetPage(name: LocalRoutes.store, page: () => const StoreScreen()),
    GetPage(name: LocalRoutes.cart, page: () => const CartScreen()),
    GetPage(name: LocalRoutes.wishlist, page: () => const WishlistScreen()),
    GetPage(name: LocalRoutes.order, page: () => const MyOrderScreen()),
    GetPage(name: LocalRoutes.setting, page: () => const SettingScreen()),
    GetPage(name: LocalRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: LocalRoutes.allBrand, page: () => const AllBrandViewScreen()),
    GetPage(name: LocalRoutes.productReview, page: () => const ProductReviewScreen()),
    GetPage(name: LocalRoutes.navigationMenu, page: () => const NavigationMenu()),
  ];
}