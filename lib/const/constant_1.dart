import 'package:flutter/material.dart';



// const kMainColor = Color(0xFF3F8CFF);

//Grocery App
const groceryMainColor = Color(0xFF27AE60);
const groceryTextColor = Color(0xFFFFFFFF);
const groceryGreyTextColor = Color(0xFFB9BBC8);

//Shoes
const kGreyTextColor = Color(0xFF828282);
const kMainColor = Color(0xFFFDC9A9);
const kTitleColor = Color(0xFF1A1A1A);
const kDarkWhite = Color(0xFFFAFAFA);
const kBorderColorTextField = Color(0xFFE8E7E5);
//Watch
const watchMainColor = Color(0xFF524EB7);
const watchTitleColor = Color(0xFF060606);
const watchGreyTextColor = Color(0xFFA6A6A6);
const watchSecondaryColor = Color(0xFFF76631);
const watchSecondaryTextColor = Color(0xFF282344);


//Furniture
const furnitureMainColor = Color(0xFFFF7F00);
const furnitureGreyTextColor = Color(0xFFA6A6A6);
const furnitureTitleColor = Color(0xFF060606);

//Electronics
const electronicMainColor = Color(0xFF1695FA);
const electronicDarkWhite = Color(0xFFEFEFEF);

const kTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Display'
);
const kButtonDecoration = BoxDecoration(
  color: kMainColor,
  borderRadius: BorderRadius.all(
    Radius.circular(40.0),
  ),
);

const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: kBorderColorTextField),
  );
}
final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

List<String> businessCategory = [
  'Fashion Store',
  'Electronics Store',
  'Computer Store',
  'Vegetable Store',
  'Sweet Store',
  'Meat Store'
];
List<String> language = [
  'English',
  'Bengali',
  'Hindi',
  'Urdu',
  'French',
  'Spanish'
];

List<String> productCategory = [
  'Fashion',
  'Electronics',
  'Computer',
  'Gadgets',
  'Watches',
  'Cloths'
];


List<String> userRole = [
  'Super Admin',
  'Admin',
  'User',
];

List<String> paymentType = [
  'Cheque',
  'Deposit',
  'Cash',
  'Transfer',
  'Sales',
];
List<String> posStats = [
  'Daily',
  'Monthly',
  'Yearly',
];
List<String> saleStats = [
  'Weekly',
  'Monthly',
  'Yearly',
];

