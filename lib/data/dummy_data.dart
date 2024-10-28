import 'package:shopping_server/features/shop/models/products/product_attribute_model.dart';
import 'package:shopping_server/features/shop/models/products/product_variation_model.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';

import '../features/shop/models/banner_model.dart';
import '../features/shop/models/brand_model.dart';
import '../features/shop/models/category_model.dart';
import '../features/shop/models/products/product_model.dart';
import '../routes/routes.dart';

class DummyData {
  // --------------------- BANNER DUMMY DATA ---------------------

  // ----- Banners
  static final List<BannerModel> banners = [
    BannerModel(
        image: LocalImages.banner1,
        active: true,
        targetScreen: LocalRoutes.wishlist),
    BannerModel(
        image: LocalImages.banner2,
        active: true,
        targetScreen: LocalRoutes.cart),
    BannerModel(
        image: LocalImages.banner3,
        active: true,
        targetScreen: LocalRoutes.order),
  ];

  // --------------------- BRAND DUMMY DATA ---------------------

  // ----- Brands
  static final nike = BrandModel(id: 'B01', brandName: 'Nike', image: LocalImages.nikeIconDark);
  static final adidas = BrandModel(id: 'B02', brandName: 'Adidas', image: LocalImages.adidasIconDark);
  static final puma = BrandModel(id: 'B03', brandName: 'Puma', image: LocalImages.pumaIconDark);
  static final underArmour = BrandModel(id: 'B04', brandName: 'Under Armour', image: LocalImages.underArmourIconDark);
  static final yonex = BrandModel(id: 'B05', brandName: 'Yonex', image: LocalImages.yonexIconDark);

  static final List<BrandModel> brands = [
    BrandModel(
        id: 'B01',
        brandName: 'Nike',
        image: LocalImages.nikeIconDark,
        isFeature: true),
    BrandModel(
        id: 'B02',
        brandName: 'Adidas',
        image: LocalImages.adidasIconDark,
        isFeature: true),
    BrandModel(
        id: 'B03',
        brandName: 'Puma',
        image: LocalImages.pumaIconDark,
        isFeature: true),
    BrandModel(
        id: 'B04',
        brandName: 'Under Armour',
        image: LocalImages.underArmourIconDark,
        isFeature: true),
    BrandModel(
        id: 'B05',
        brandName: 'Yonex',
        image: LocalImages.yonexIconDark,
        isFeature: true),
  ];

  // --------------------- CATEGORY DUMMY DATA ---------------------

  // ----- Categories
  static final List<CategoryModel> categories = [
    // --- Feature Categories
    CategoryModel(
        id: 'C01',
        name: 'Sport',
        image: LocalImages.sportIcon,
        isFeature: true,
    ),
    CategoryModel(
        id: 'C02',
        name: 'Clothes',
        image: LocalImages.clothesIcon,
        isFeature: true,
    ),
    CategoryModel(
        id: 'C03',
        name: 'Accessories',
        image: LocalImages.accessoryIcon,
        isFeature: true,
    ),

    //----- Sub Category
    CategoryModel(
        id: 'C01-S01',
        name: 'Shoes',
        image: LocalImages.shoes,
        isFeature: true,
        parentId: 'C01',
    ),
    CategoryModel(
        id: 'C01-S02',
        name: 'Tennis',
        image: LocalImages.sportToolIcon,
        isFeature: true,
        parentId: 'C01',
    ),
    CategoryModel(
        id: 'C02-S01',
        name: 'Pants & Leggings',
        image: LocalImages.pantsIcon,
        isFeature: true,
        parentId: 'C02',
    ),
    CategoryModel(
        id: 'C02-S02',
        name: 'Hoodies & Jackets',
        image: LocalImages.hoodieIcon,
        isFeature: true,
        parentId: 'C02',
    ),
    CategoryModel(
        id: 'C02-S03',
        name: 'Shirts',
        image: LocalImages.hoodieIcon,
        isFeature: true,
        parentId: 'C02',
    ),
    CategoryModel(
        id: 'C03-S01',
        name: 'Hats',
        image: LocalImages.hatIcon,
        isFeature: true,
        parentId: 'C03',
    ),
    CategoryModel(
        id: 'C03-S02',
        name: 'Bags & Backpacks',
        image: LocalImages.bagIcon,
        isFeature: true,
        parentId: 'C03',
    ),
  ];

  // --------------------- PRODUCT DUMMY DATA ---------------------

  // ----- Products
  static final List<ProductModel> products = [
    ProductModel(
        id: 'P01',
        title: 'Nike Air Shoes',
        thumbnail: LocalImages.nikeBlueShoes,
        productType: 'ProductType.variable',
        stock: 35,
        price: 125,
        salePrice: 100,
        sku: 'ABR4568',
        categoryId: 'C01-S01',
        description: 'Shoes made by Nike.',
        isFeature: true,
        brand: DummyData.nike,
        images: [
          LocalImages.nikeRedShoes,
          LocalImages.nikeGreenShoes,
          LocalImages.nikeBlueShoes
        ],
        productAttribute: [
          ProductAttributeModel(
              name: 'Color', values: ['Blue', 'Green', 'Red']),
          ProductAttributeModel(
              name: 'Size', values: ['EU 32', 'EU 34', 'EU 36']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0101',
            description: 'Green Shoes made by Nike.',
            price: 110,
            salePrice: 90,
            stock: 10,
            attributeValue: {'Color': 'Green', 'Size': 'EU 34'},
            image: LocalImages.nikeGreenShoes,
          ),
          ProductVariationModel(
            id: 'P0102',
            description: 'Red Shoes made by Nike.',
            price: 120,
            salePrice: 100,
            stock: 15,
            attributeValue: {'Color': 'Red', 'Size': 'EU 32'},
            image: LocalImages.nikeRedShoes,
          ),
          ProductVariationModel(
            id: 'P0103',
            description: 'Blue Shoes made by Nike.',
            price: 110,
            salePrice: 90,
            stock: 12,
            attributeValue: {'Color': 'Blue', 'Size': 'EU 36'},
            image: LocalImages.nikeBlueShoes,
          ),
        ],
    ),
    ProductModel(
        id: 'P02',
        title: 'Adidas Jacket',
        description: 'Jacket made by Adidas.',
        thumbnail: LocalImages.adidasBlackJacket,
        productType: 'ProductType.variable',
        stock: 32,
        price: 75,
        salePrice: 50,
        sku: 'ABR4567',
        brand: DummyData.adidas,
        isFeature: true,
        categoryId: 'C02-S02',
        images: [
          LocalImages.adidasBlackJacket,
          LocalImages.adidasBlueJacket
        ],
        productAttribute: [
          ProductAttributeModel(name: 'Color', values: ['Black', 'Blue']),
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0201',
            attributeValue: {'Color': 'Black', 'Size': 'S'},
            description: 'Black jacket made by Adidas.',
            price: 60,
            salePrice: 40,
            stock: 35,
            image: LocalImages.adidasBlackJacket,
          ),
          ProductVariationModel(
            id: 'P0202',
            attributeValue: {'Color': 'Blue', 'Size': 'M'},
            description: 'Blue jacket made by Adidas.',
            price: 75,
            salePrice: 50,
            stock: 25,
            image: LocalImages.adidasBlueJacket,
          ),
        ],
    ),
    ProductModel(
        id: 'P03',
        title: 'Adidas Pants',
        description: 'Pants made by Adidas.',
        thumbnail: LocalImages.adidasBlackPants,
        productType: 'ProductType.variable',
        stock: 21,
        price: 120,
        salePrice: 100,
        sku: 'ABR4567',
        brand: DummyData.adidas,
        isFeature: true,
        categoryId: 'C02-S01',
        images: [
          LocalImages.adidasBlackPants,
          LocalImages.adidasBluePants
        ],
        productAttribute: [
          ProductAttributeModel(name: 'Color', values: ['Black', 'Blue']),
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0301',
            attributeValue: {'Color': 'Black', 'Size': 'S'},
            description: 'Black pants made by Adidas.',
            price: 110,
            salePrice: 80,
            stock: 15,
            image: LocalImages.adidasBlackPants,
          ),
          ProductVariationModel(
            id: 'P0302',
            attributeValue: {'Color': 'Blue', 'Size': 'M'},
            description: 'Blue pants made by Adidas.',
            price: 120,
            salePrice: 90,
            stock: 58,
            image: LocalImages.adidasBluePants,
          ),
        ],
    ),
    ProductModel(
        id: 'P04',
        title: 'Under Armour Polo',
        description: 'Polo made by Under Armour.',
        thumbnail: LocalImages.uaWhitePolo,
        productType: 'ProductType.variable',
        stock: 23,
        price: 220,
        salePrice: 180,
        sku: 'ABR4567',
        brand: DummyData.underArmour,
        isFeature: true,
        categoryId: 'C02-S03',
        images: [
          LocalImages.uaWhitePolo,
          LocalImages.uaBlackPolo
        ],
        productAttribute: [
          ProductAttributeModel(name: 'Color', values: ['Black', 'White']),
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0401',
            attributeValue: {'Color': 'Black', 'Size': 'S'},
            description: 'Black polo made by Under Armour.',
            price: 220,
            salePrice: 180,
            stock: 16,
            image: LocalImages.uaBlackPolo,
          ),
          ProductVariationModel(
            id: 'P0402',
            attributeValue: {'Color': 'White', 'Size': 'M'},
            description: 'White polo made by Under Armour.',
            price: 210,
            salePrice: 190,
            stock: 38,
            image: LocalImages.uaWhitePolo,
          ),
        ],
    ),
    ProductModel(
        id: 'P05',
        title: 'Under Armour Short Sleeve',
        description: 'Short Sleeve made by Under Armour.',
        thumbnail: LocalImages.uaBlueShortSleeve,
        productType: 'ProductType.variable',
        stock: 21,
        price: 50,
        salePrice: 30,
        sku: 'ABR4567',
        brand: DummyData.underArmour,
        isFeature: true,
        categoryId: 'C02-S03',
        images: [
          LocalImages.uaBlueShortSleeve,
          LocalImages.uaBlackShortSleeve,
          LocalImages.uaGrayShortSleeve
        ],
        productAttribute: [
          ProductAttributeModel(
              name: 'Color', values: ['Black', 'Blue', 'Grey']),
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0501',
            attributeValue: {'Color': 'Black', 'Size': 'S'},
            description: 'Black short sleeve made by Under Armour.',
            price: 40,
            salePrice: 20,
            stock: 15,
            image: LocalImages.uaBlackShortSleeve,
          ),
          ProductVariationModel(
            id: 'P0502',
            attributeValue: {'Color': 'Blue', 'Size': 'M'},
            description: 'Blue short sleeve made by Under Armour.',
            price: 50,
            salePrice: 25,
            stock: 12,
            image: LocalImages.uaBlueShortSleeve,
          ),
          ProductVariationModel(
            id: 'P0503',
            attributeValue: {'Color': 'Grey', 'Size': 'L'},
            description: 'Grey short sleeve made by Under Armour.',
            price: 40,
            salePrice: 20,
            stock: 22,
            image: LocalImages.uaGrayShortSleeve,
          ),
        ],
    ),
    ProductModel(
        id: 'P06',
        title: 'Under Armour Hoodie',
        description: 'Hoodie made by Under Armour.',
        thumbnail: LocalImages.uaWhiteHoodie,
        productType: 'ProductType.variable',
        stock: 11,
        price: 150,
        salePrice: 130,
        sku: 'ABR4567',
        brand: DummyData.underArmour,
        isFeature: true,
        categoryId: 'C02-S02',
        images: [
          LocalImages.uaWhiteHoodie,
          LocalImages.uaBlueHoodie,
          LocalImages.uaRedHoodie
        ],
        productAttribute: [
          ProductAttributeModel(
              name: 'Color', values: ['White', 'Blue', 'Red']),
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0601',
            attributeValue: {'Color': 'White', 'Size': 'S'},
            description: 'White hoodie made by Under Armour.',
            price: 140,
            salePrice: 120,
            stock: 5,
            image: LocalImages.uaWhiteHoodie,
          ),
          ProductVariationModel(
            id: 'P0602',
            attributeValue: {'Color': 'Blue', 'Size': 'M'},
            description: 'Blue hoodie made by Under Armour.',
            price: 150,
            salePrice: 125,
            stock: 2,
            image: LocalImages.uaBlueHoodie,
          ),
          ProductVariationModel(
            id: 'P0603',
            attributeValue: {'Color': 'Red', 'Size': 'L'},
            description: 'Red hoodie made by Under Armour.',
            price: 140,
            salePrice: 120,
            stock: 4,
            image: LocalImages.uaRedHoodie,
          ),
        ],
    ),
    ProductModel(
        id: 'P07',
        title: 'Puma sport pants',
        description: 'Sport pants made by Puma.',
        thumbnail: LocalImages.pumaBlackPants,
        productType: 'ProductType.variable',
        stock: 21,
        price: 60,
        salePrice: 50,
        sku: 'ABR4567',
        brand: DummyData.puma,
        isFeature: true,
        categoryId: 'C02-S01',
        images: [
          LocalImages.pumaBlackPants,
          LocalImages.pumaBrownPants
        ],
        productAttribute: [
          ProductAttributeModel(name: 'Color', values: ['Black', 'Brown']),
          ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0701',
            attributeValue: {'Color': 'Black', 'Size': 'S'},
            description: 'Black sport pants made by Puma.',
            price: 60,
            salePrice: 50,
            stock: 5,
            image: LocalImages.pumaBlackPants,
          ),
          ProductVariationModel(
            id: 'P0702',
            attributeValue: {'Color': 'Brown', 'Size': 'M'},
            description: 'Brown sport pants made by Puma.',
            price: 50,
            salePrice: 40,
            stock: 16,
            image: LocalImages.pumaBrownPants,
          ),
        ],
    ),
    ProductModel(
        id: 'P08',
        title: 'Puma sport sneakers',
        description: 'Sport sneakers made by Puma.',
        thumbnail: LocalImages.pumaBlackShoes,
        productType: 'ProductType.variable',
        stock: 10,
        price: 160,
        salePrice: 140,
        sku: 'ABR4567',
        brand: DummyData.puma,
        isFeature: true,
        categoryId: 'C01-S01',
        images: [
          LocalImages.pumaBlackShoes,
          LocalImages.pumaBlueShoes,
          LocalImages.pumaGreenShoes
        ],
        productAttribute: [
          ProductAttributeModel(
              name: 'Color', values: ['Black', 'Blue', 'Green']),
          ProductAttributeModel(
              name: 'Size', values: ['EU 36', 'EU 38', 'EU 40']),
        ],
        productVariation: [
          ProductVariationModel(
            id: 'P0801',
            attributeValue: {'Color': 'Black', 'Size': 'EU 36'},
            description: 'Black sport sneakers made by Puma.',
            price: 160,
            salePrice: 140,
            stock: 3,
            image: LocalImages.pumaBlackShoes,
          ),
          ProductVariationModel(
            id: 'P0802',
            attributeValue: {'Color': 'Blue', 'Size': 'EU 38'},
            description: 'Blue sport sneakers made by Puma.',
            price: 150,
            salePrice: 140,
            stock: 7,
            image: LocalImages.pumaBlueShoes,
          ),
          ProductVariationModel(
            id: 'P0803',
            attributeValue: {'Color': 'Green', 'Size': 'EU 40'},
            description: 'Green sport sneakers made by Puma.',
            price: 150,
            salePrice: 140,
            stock: 4,
            image: LocalImages.pumaGreenShoes,
          ),
        ],
    ),
    ProductModel(
      id: 'P09',
      title: 'Puma Black Tee',
      description: 'Black Tee made by Puma.',
      thumbnail: LocalImages.pumaTeeFront,
      productType: 'ProductType.single',
      stock: 20,
      price: 60,
      salePrice: 40,
      sku: 'ABR4567',
      brand: DummyData.puma,
      isFeature: true,
      categoryId: 'C02-S03',
      images: [LocalImages.pumaTeeFront, LocalImages.pumaTeeBack],
      productAttribute: [
        ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
      ],
    ),
    ProductModel(
      id: 'P010',
      title: 'Puma Daisy Long Sleeve',
      description: 'Daisy Long Sleeve made by Puma.',
      thumbnail: LocalImages.pumaLongSleeve,
      productType: 'ProductType.single',
      stock: 24,
      price: 70,
      salePrice: 60,
      sku: 'ABR4567',
      brand: DummyData.puma,
      isFeature: true,
      categoryId: 'C02-S03',
    ),
    ProductModel(
      id: 'P011',
      title: 'Puma Backpack',
      thumbnail: LocalImages.pumaBackpack1,
      productType: 'ProductType.single',
      stock: 14,
      price: 155,
      isFeature: true,
      salePrice: 0,
      description: 'Backpack made by Puma',
      sku: 'ABR4567',
      brand: DummyData.puma,
      categoryId: 'C03-S02',
      images: [LocalImages.pumaBackpack1, LocalImages.pumaBackpack2],
    ),
    ProductModel(
      id: 'P012',
      title: 'Yonex Tennis Racket',
      thumbnail: LocalImages.yonexTennisRacket,
      productType: 'ProductType.single',
      stock: 22,
      price: 155,
      isFeature: true,
      salePrice: 0,
      description: 'Tennis racket made by Yonex',
      sku: 'ABR4567',
      brand: DummyData.yonex,
      categoryId: 'C01-S02',
      images: [LocalImages.yonexTennisRacket],
    ),
    ProductModel(
      id: 'P013',
      title: 'Puma Waist Bag',
      thumbnail: LocalImages.pumaWaistBag1,
      productType: 'ProductType.single',
      stock: 10,
      price: 50,
      isFeature: true,
      salePrice: 40,
      description: 'Waist bag made by Puma',
      sku: 'ABR4567',
      brand: DummyData.puma,
      categoryId: 'C03-S02',
      images: [LocalImages.pumaWaistBag1, LocalImages.pumaWaistBag2],
    ),
    ProductModel(
      id: 'P014',
      title: 'Puma Cap',
      thumbnail: LocalImages.pumaBlackCap1,
      productType: 'ProductType.variable',
      stock: 30,
      price: 20,
      isFeature: true,
      salePrice: 14,
      description: 'Cap made by Puma',
      sku: 'ABR4567',
      brand: DummyData.puma,
      categoryId: 'C03-S01',
      images: [
        LocalImages.pumaBlackCap1,
        LocalImages.pumaBlackCap2,
        LocalImages.pumaBlueCap1,
        LocalImages.pumaBlueCap2,
      ],
      productAttribute: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'Blue']),
        ProductAttributeModel(name: 'Size', values: ['OSFA']),
      ],
      productVariation: [
        ProductVariationModel(
          id: 'P0141',
          attributeValue: {'Color': 'Black', 'Size': 'OSFA'},
          sku: 'ABR4567',
          description: 'Black cap made by Puma.',
          price: 20,
          salePrice: 0,
          image: LocalImages.pumaBlackCap1,
          stock: 16,
        ),
        ProductVariationModel(
          id: 'P0142',
          attributeValue: {'Color': 'Blue', 'Size': 'OSFA'},
          sku: 'ABR4567',
          description: 'Blue cap made by Puma.',
          price: 20,
          salePrice: 14,
          image: LocalImages.pumaBlueCap1,
          stock: 14,
        ),
      ],
    ),
  ];
}
