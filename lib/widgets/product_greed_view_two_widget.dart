import 'package:flutter/material.dart';
import 'package:maanstore/screens/product_details_screen/product_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: library_prefixes
import '../const/constant_1.dart' as newConstant;
import '../const/constant_1.dart';
import '../models/product_model.dart';
import '../models/single_product_variations_model.dart';

class ProductGreedShowTwo extends StatefulWidget {
  const ProductGreedShowTwo({
    Key? key,
    required this.discountPercentage,
    required this.isSingleView,
    required this.categoryId,
    required this.productModel,
    this.singleProductVariations,
    this.index,
  }) : super(key: key);
  final SingleProductVariations? singleProductVariations;
  final String discountPercentage;
  final bool isSingleView;
  final int categoryId;
  final ProductModel productModel;
  final int? index;

  @override
  State<ProductGreedShowTwo> createState() => _ProductGreedShowTwoState();
}

class _ProductGreedShowTwoState extends State<ProductGreedShowTwo> {
  List<String> newItemReview = [
    '4.9 (27 review)',
    '4.9 (27 review)',
  ];
  List<Color> newColorList = [
    const Color(0xFFF6EAFF),
    const Color(0xFFE4F2FF),
    const Color(0xFFEDECFF),
    const Color(0xFFFFF1E0),
    const Color(0xFFF1FFF4),
  ];
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 230,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      ProductDetailScreen(
                        productModel: widget.productModel,
                        categoryId: widget.categoryId,
                      ).launch(context);
                    },
                    child: Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.productModel.images![0].src.toString(),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                            ),
                            color: watchSecondaryColor),
                        height: 20,
                        width: 40,
                        child: Center(
                            child: Text(
                          '${widget.discountPercentage}%',
                          style: newConstant.kTextStyle.copyWith(color: Colors.white),
                        )),
                      ).visible(widget.discountPercentage.toInt() != 202),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0),
                child: Text(
                  widget.productModel.name.toString(),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: newConstant.kTextStyle.copyWith(color: watchTitleColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBarWidget(
                    onRatingChanged: null,
                    itemCount: 1,
                    activeColor: const Color(0xFFFF9900),
                    size: 14.0,
                  ),
                  const SizedBox(width: 2.0),
                  Text(
                    newItemReview[0],
                    style: newConstant.kTextStyle.copyWith(color: watchGreyTextColor),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.singleProductVariations != null
                      ? Text(
                          widget.singleProductVariations!.salePrice.toInt() <= 0
                              ? '\$${widget.singleProductVariations!.regularPrice}'
                              : '\$${widget.singleProductVariations!.salePrice}',
                          style: newConstant.kTextStyle.copyWith(color: watchTitleColor, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          widget.productModel.salePrice.toInt() <= 0 ? '\$${widget.productModel.regularPrice}' : '\$${widget.productModel.salePrice}',
                          style: newConstant.kTextStyle.copyWith(color: watchTitleColor, fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(width: 5.0),
                  widget.singleProductVariations != null
                      ? Text(
                          '\$${widget.singleProductVariations!.regularPrice}',
                          style: newConstant.kTextStyle.copyWith(color: kGreyTextColor, decoration: TextDecoration.lineThrough),
                        ).visible(widget.discountPercentage.toInt() != 202)
                      : Text(
                          '\$${widget.productModel.regularPrice}',
                          style: newConstant.kTextStyle.copyWith(color: kGreyTextColor, decoration: TextDecoration.lineThrough),
                        ).visible(widget.discountPercentage.toInt() != 202),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
