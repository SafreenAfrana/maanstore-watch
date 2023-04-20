import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/wishlist_model.dart';

bool isRtl = false;

//Paypal Settings
const String paypalClientId =
    'ATKxCBB49G3rPw4DG_0vDmygbZeFKubzub7jGWpeUW5jzfElK9qOzqJOfrBTYvS7RuIhoPdWHB4DIdLJ';
const String paypalClientSecret =
    'EIDqVfraXlxDBMnswmhqP2qYv6rr_KPDgK269T-q1K9tB455OpPL_fc65irFiPBpiVXcoOQwpKqU3PAu';
const bool sandbox = true;
const String currency = 'USD';

//Onesignal Settings
const String oneSignalAppId = '5991efe6-21f5-4900-b8ba-2cf0e25f10e3';

const int bestSellingProduct = 29;
const int flashSale = 30;
const int newArrive = 31;
const String currencySign = '\$';
const String shippingCountry = 'India';



const primaryColor = Color(0xFF3E3E70);
const secondaryColor1 = Color(0xFFE2396C);
const secondaryColor2 = Color(0xFFFBFBFB);
const secondaryColor3 = Color(0xFFE5E5E5);
const titleColors = Color(0xFF1A1A1A);
const textColors = Color(0xFF828282);
const ratingColor = Color(0xFFFFB03A);

const categoryColor1 = Color(0xFFFCF3D7);
const categoryColor2 = Color(0xFFDCF7E3);
List<Wishlist> wishList = [];
int? wishListItems;
Future<void> addToWishList(Wishlist wishLists) async {
  wishList.add(wishLists);
  String encodedData = Wishlist.encode(wishList);
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('wishListProducts', encodedData);
  //final getData = prefs.getString('wishListProducts');
  //final decodedData = Wishlist.decode(getData!);
}

final TextStyle kTextStyle = GoogleFonts.dmSans(
  textStyle: const TextStyle(
    color: textColors,
    fontSize: 16,
  ),
);

class MyGoogleText extends StatelessWidget {
  const MyGoogleText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontColor,
      required this.fontWeight})
      : super(key: key);
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
        ),
      ),
      maxLines: 1,
    );
  }
}

class MyGoogleTextWhitAli extends StatelessWidget {
  const MyGoogleTextWhitAli({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.textAlign,
  }) : super(key: key);
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: secondaryColor1),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
