import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/data/dummy_data.dart';
import 'package:shopping_server/data/repositories/banner_repository.dart';
import 'package:shopping_server/data/repositories/brand_repository.dart';
import 'package:shopping_server/data/repositories/category_repository.dart';
import 'package:shopping_server/data/repositories/product_repository.dart';
import 'package:shopping_server/features/personalization/views/setting/widgets/setting_menu_title.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryRepository = CategoryRepository.instance;
    final bannerRepository = BannerRepository.instance;
    final productRepository = ProductRepository.instance;
    final brandRepository = Get.put(BrandRepository());

    return Scaffold(
      // ----- AppBar
      appBar: const CustomAppbar(
        title: Text('Upload Data'),
        showBackArrow: true,
      ),

      // ----- Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          children: [
            const SectionHeading(title: 'Main Record', showActionButton: false),
            const SizedBox(height: AppSize.spaceBtwItems),
            // ----- Upload Category
            SettingMenuTitle(
              iconLeading: Iconsax.menu,
              title: 'Upload Categories',
              subtitle: 'Upload all category data in local assets.',
              trailing: const Icon(Iconsax.arrow_circle_up),
              onTap: () => categoryRepository.uploadDummyData(DummyData.categories),
            ),
            const SizedBox(height: AppSize.small),

            // ----- Upload Banner
            SettingMenuTitle(
              iconLeading: Iconsax.image,
              title: 'Upload Banners',
              subtitle: 'Upload all banner data in local assets.',
              trailing: const Icon(Iconsax.arrow_circle_up),
              onTap: () => bannerRepository.uploadDummyData(DummyData.banners),
            ),
            const SizedBox(height: AppSize.small),

            // ----- Upload Product
            SettingMenuTitle(
              iconLeading: Iconsax.box,
              title: 'Upload Products',
              subtitle: 'Upload all product data in local assets.',
              trailing: const Icon(Iconsax.arrow_circle_up),
              onTap: () => productRepository.uploadDummyData(DummyData.products),
            ),

            // ----- Upload Brand
            SettingMenuTitle(
              iconLeading: Iconsax.tag,
              title: 'Upload Brands',
              subtitle: 'Upload all brand data in local assets.',
              trailing: const Icon(Iconsax.arrow_circle_up),
              onTap: () => brandRepository.uploadDummyData(DummyData.brands),
            ),
          ],
        ),
      ),
    );
  }
}
