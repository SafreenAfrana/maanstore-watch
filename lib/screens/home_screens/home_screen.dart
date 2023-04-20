import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maanstore/screens/search_product_screen.dart';
import 'package:maanstore/widgets/product_greed_view_two_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../Providers/all_repo_providers.dart';
import '../../api_service/api_service.dart';
import '../../const/constant_1.dart';
// ignore: library_prefixes
import '../../const/constant_1.dart' as newConstant;
import '../../const/constants.dart';
import '../../const/hardcoded_text.dart';
import '../../const/hardcoded_text_arabic.dart';
import '../../models/category_model.dart';
import '../../widgets/banner_shimmer_widget.dart';
import '../../widgets/product_greed_view_widget.dart';
import '../../widgets/product_shimmer_widget.dart';
import '../category_screen/single_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  APIService? apiService;
  int? customerId = 0;
  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, __) {
      final singleCategory = ref.watch(getProductOfSingleCategory(newArrive));
      final bestSellingProducts = ref.watch(getProductOfSingleCategory(bestSellingProduct));
      final specialOffers = ref.watch(getProductOfSingleCategory(flashSale));
      final allCategory = ref.watch(getAllCategories);
      final allBanner = ref.watch(getBanner);
      final allCoupons = ref.watch(getCoupon);
      return Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            titleSpacing: 0.0,
            title: MyGoogleText(
              text: isRtl ? HardcodedTextArabic.appName : HardcodedTextEng.appName,
              fontSize: 20,
              fontColor: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            leading: Padding(
              padding: const EdgeInsets.all(4),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      image: DecorationImage(image: AssetImage(HardcodedImages.appLogo))),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: secondaryColor3,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      const SearchProductScreen().launch(context);
                    },
                    icon: const Icon(
                      FeatherIcons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: secondaryColor3,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FeatherIcons.bell,
                      color: Colors.black,
                    ),
                  ),
                ),
              ).visible(false),
              const SizedBox(width: 8.0),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///_____________Offer_Images_______________________________________________
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: allBanner.when(data: (snapShot) {
                      return HorizontalList(
                        padding: EdgeInsets.zero,
                        spacing: 10.0,
                        itemCount: snapShot.length,
                        itemBuilder: (_, i) {
                          return Container(
                            height: 120,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snapShot[i].guid!.rendered.toString(),
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          );
                        },
                      );
                    }, error: (e, stack) {
                      return Text(e.toString());
                    }, loading: () {
                      return const BannerShimmerWidget();
                    }),
                  ),

                  ///_____________Category_______________________________________________
                  const SizedBox(height: 20.0),
                  allCategory.when(data: (snapShot) {
                    return _buildCategoryList(snapShot);
                  }, error: (e, stack) {
                    return Text(e.toString());
                  }, loading: () {
                    return HorizontalList(
                        padding: EdgeInsets.zero,
                        spacing: 10.0,
                        itemCount: 5,
                        itemBuilder: (_, i) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                padding: const EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
                                width: 100.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                          color: black,
                                          borderRadius: BorderRadius.circular(
                                            30.0,
                                          )),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      '',
                                      style: newConstant.kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ));
                        });
                  }),
                  const SizedBox(height: 20.0),

                  ///_____________Special Offers_______________________________________________
                  Row(
                    children: [
                      Text(
                        isRtl ? HardcodedTextArabic.section1 : HardcodedTextEng.section1,
                        style: newConstant.kTextStyle.copyWith(color: watchSecondaryTextColor, fontSize: 18.0),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          SingleCategoryScreen(
                            categoryId: flashSale,
                            categoryName: isRtl ? HardcodedTextArabic.section1 : HardcodedTextEng.section1,
                            categoryList: const [],
                            categoryModel: CategoryModel(),
                          ).launch(context);
                        },
                        child: Text(
                          isRtl ? HardcodedTextArabic.showAllButton : HardcodedTextEng.showAllButton,
                          style: newConstant.kTextStyle.copyWith(color: watchGreyTextColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  specialOffers.when(data: (snapshot) {
                    return HorizontalList(
                        padding: EdgeInsets.zero,
                        spacing: 0,
                        itemCount: snapshot.length,
                        itemBuilder: (_, index) {
                          final productVariation = ref.watch(getSingleProductVariation(snapshot[index].id!.toInt()));

                          return productVariation.when(data: (snapData) {
                            if (snapshot[index].type != 'simple' && snapData.isNotEmpty) {
                              int discount = discountGenerator(snapshot[0].regularPrice.toString(), snapshot[0].salePrice.toString());
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ProductGreedShowTwo(
                                  index: index,
                                  singleProductVariations: snapData[0],
                                  productModel: snapshot[index],
                                  discountPercentage: discount.toString(),
                                  isSingleView: false,
                                  categoryId: flashSale,
                                ),
                              );
                            } else {
                              int discount = discountGenerator(snapshot[index].regularPrice.toString(), snapshot[index].salePrice.toString());
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ProductGreedShowTwo(
                                  index: index,
                                  productModel: snapshot[index],
                                  discountPercentage: discount.toString(),
                                  isSingleView: false,
                                  categoryId: flashSale,
                                ),
                              );
                            }
                          }, error: (e, stack) {
                            return Text(e.toString());
                          }, loading: () {
                            return Container();
                          });
                        });
                  }, error: (e, stack) {
                    return Text(e.toString());
                  }, loading: () {
                    return const Center(child: ProductShimmerWidget());
                  }),

                  ///_____________Trending_watch_______________________________________________
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        isRtl ? HardcodedTextArabic.section2 : HardcodedTextEng.section2,
                        style: newConstant.kTextStyle.copyWith(color: watchSecondaryTextColor, fontSize: 18.0),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          SingleCategoryScreen(
                            categoryId: bestSellingProduct,
                            categoryName: isRtl ? HardcodedTextArabic.section2 : HardcodedTextEng.section2,
                            categoryList: const [],
                            categoryModel: CategoryModel(),
                          ).launch(context);
                        },
                        child: Text(
                          isRtl ? HardcodedTextArabic.showAllButton : HardcodedTextEng.showAllButton,
                          style: newConstant.kTextStyle.copyWith(color: watchGreyTextColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  bestSellingProducts.when(data: (snapshot) {
                    return HorizontalList(
                        padding: EdgeInsets.zero,
                        spacing: 0,
                        itemCount: snapshot.length,
                        itemBuilder: (_, index) {
                          final productVariation = ref.watch(getSingleProductVariation(snapshot[index].id!.toInt()));

                          return productVariation.when(data: (dataSnap) {
                            if (snapshot[index].type != 'simple' && dataSnap.isNotEmpty) {
                              int discount = discountGenerator(dataSnap[0].regularPrice.toString(), dataSnap[0].salePrice.toString());
                              return Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: ProductGreedShow(
                                  index: index,
                                  singleProductVariations: dataSnap[0],
                                  productModel: snapshot[index],
                                  discountPercentage: discount.toString(),
                                  isSingleView: false,
                                  categoryId: bestSellingProduct,
                                ),
                              );
                            } else {
                              int discount =
                              discountGenerator(snapshot[index].regularPrice.toString(), snapshot[index].salePrice.toString());
                              return Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: ProductGreedShow(
                                  index: index,
                                  productModel: snapshot[index],
                                  discountPercentage: discount.toString(),
                                  isSingleView: false,
                                  categoryId: bestSellingProduct,
                                ),
                              );
                            }
                          }, error: (e, stack) {
                            return Text(e.toString());
                          }, loading: () {
                            return Container();
                          });
                        });
                  }, error: (e, stack) {
                    return Text(e.toString());
                  }, loading: () {
                    return const Center(child: ProductShimmerWidget());
                  }),

                  ///___________Promo__________________________________________

                  const SizedBox(height: 10),
                  allCoupons.when(data: (snapShot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HorizontalList(
                        padding: EdgeInsets.zero,
                        spacing: 10.0,
                        itemCount: snapShot.length,
                        itemBuilder: (_, i) {
                          return Container(
                            height: 130,
                            width: context.width() / 1.2,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(HardcodedImages.couponBackgroundImage), fit: BoxFit.fill),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyGoogleText(
                                  text: '${snapShot[i].amount}% OFF',
                                  fontSize: 24,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                                const SizedBox(height: 10),
                                MyGoogleText(
                                  text: 'USE CODE: ${snapShot[i].code.toString()}',
                                  fontSize: 16,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }, error: (e, stack) {
                    return Text(e.toString());
                  }, loading: () {
                    return const BannerShimmerWidget();
                  }),

                  ///_____________New_Arrivals__________________________________________________
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        isRtl ? HardcodedTextArabic.section3 : HardcodedTextEng.section3,
                        style: newConstant.kTextStyle.copyWith(color: watchSecondaryTextColor, fontSize: 18.0),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          SingleCategoryScreen(
                            categoryId: newArrive,
                            categoryName: isRtl ? HardcodedTextArabic.section3 : HardcodedTextEng.section3,
                            categoryList: const [],
                            categoryModel: CategoryModel(),
                          ).launch(context);
                        },
                        child: Text(
                          isRtl ? HardcodedTextArabic.showAllButton : HardcodedTextEng.showAllButton,
                          style: newConstant.kTextStyle.copyWith(color: watchGreyTextColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  singleCategory.when(data: (snapshot) {
                    return HorizontalList(
                        padding: EdgeInsets.zero,
                        spacing: 0,
                        itemCount: snapshot.length,
                        itemBuilder: (_, index) {

                          final productVariation = ref.watch(getSingleProductVariation(snapshot[index].id!.toInt()));

                          return productVariation.when(data: (dataSnap) {
                            if (snapshot[index].type != 'simple' && dataSnap.isNotEmpty) {
                              int discount = discountGenerator(dataSnap[0].regularPrice.toString(), dataSnap[0].salePrice.toString());
                              return Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: ProductGreedShow(
                                  index: index,
                                  singleProductVariations: dataSnap[0],
                                  productModel: snapshot[index],
                                  discountPercentage: discount.toString(),
                                  isSingleView: false,
                                  categoryId: newArrive,
                                ),
                              );
                            } else {
                              int discount =
                              discountGenerator(snapshot[index].regularPrice.toString(), snapshot[index].salePrice.toString());
                              return Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: ProductGreedShow(
                                  index: index,
                                  productModel: snapshot[index],
                                  discountPercentage: discount.toString(),
                                  isSingleView: false,
                                  categoryId: newArrive,
                                ),
                              );
                            }
                          }, error: (e, stack) {
                            return Text(e.toString());
                          }, loading: () {
                            return Container();
                          });
                        });
                  }, error: (e, stack) {
                    return Text(e.toString());
                  }, loading: () {
                    return const Center(child: ProductShimmerWidget());
                  }),
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  int discountGenerator(String regularPrice, String sellingPrice) {
    double discount;

    if (regularPrice.isEmpty || sellingPrice.isEmpty) {
      return 202;
    } else {
      discount = ((double.parse(sellingPrice) * 100) / double.parse(regularPrice)) - 100;
    }

    return discount.toInt();
  }

  Widget _buildCategoryList(List<CategoryModel> categories) {
    final List<CategoryModel> finalList = [];
    for (var element in categories) {
      if (element.parent == 0) {
        finalList.add(element);
      }
    }
    return HorizontalList(
      padding: EdgeInsets.zero,
      spacing: 10.0,
      itemCount: finalList.length,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () {
            SingleCategoryScreen(
              categoryId: finalList[i].id!.toInt(),
              categoryName: finalList[i].name.toString(),
              categoryList: categories,
              categoryModel: finalList[i],
            ).launch(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    finalList[i].image?.src == null
                        ? 'https://images.all-free-download.com/images/graphiclarge/blue_abstract_background_310971.jpg'
                        : finalList[i].image!.src.toString(),
                  ),
                  backgroundColor: watchMainColor.withOpacity(0.10),
                ),
                const SizedBox(width: 5.0),
                Text(
                  finalList[i].name.toString(),
                  style: newConstant.kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
