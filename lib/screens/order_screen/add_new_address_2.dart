
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maanstore/const/hardcoded_text.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../api_service/api_service.dart';
import '../../const/constants.dart';
import '../../const/hardcoded_text_arabic.dart';
import '../../models/retrieve_customer.dart';
import '../../widgets/buttons.dart';
import 'check_out_screen.dart';

class AddNewAddressTwo extends StatefulWidget {
  const AddNewAddressTwo({Key? key, this.initShipping, this.initBilling})
      : super(key: key);
  final Shipping? initShipping;
  final Billing? initBilling;

  @override
  State<AddNewAddressTwo> createState() => _AddNewAddressTwoState();
}

class _AddNewAddressTwoState extends State<AddNewAddressTwo> {
  late APIService apiService;
  RetrieveCustomer retrieveCustomer = RetrieveCustomer();
  Shipping shipping = Shipping();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool addressSwitch = false;
  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyGoogleText(
                          text: isRtl ? HardcodedTextArabic.addNewAddressScreenName: HardcodedTextEng.addNewAddressScreenName,
                          fontSize: 20,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   icon: const Icon(Icons.close),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Form(
                      key: globalKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: isRtl
                                  ? HardcodedTextArabic.fastNameTextFieldLabel
                                  : HardcodedTextEng.fastNameTextFieldLabel,
                              hintText: isRtl
                                  ? HardcodedTextArabic.fastNameTextFieldHint
                                  : HardcodedTextEng.fastNameTextFieldHint,
                            ),
                            initialValue: widget.initShipping?.firstName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return isRtl
                                    ? HardcodedTextArabic
                                        .fastNameTextFieldValidator
                                    : HardcodedTextEng
                                        .fastNameTextFieldValidator;
                              } else if (value.length < 2) {
                                return isRtl
                                    ? HardcodedTextArabic
                                        .fastNameTextFieldValidator
                                    : HardcodedTextEng
                                        .fastNameTextFieldValidator;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.firstName = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: isRtl
                                  ? HardcodedTextArabic.lastNameTextFieldLabel
                                  : HardcodedTextEng.lastNameTextFieldLabel,
                              hintText: isRtl
                                  ? HardcodedTextArabic.lastNameTextFieldHint
                                  : HardcodedTextEng.lastNameTextFieldHint,
                            ),
                            initialValue: widget.initShipping?.lastName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return isRtl
                                    ? HardcodedTextArabic
                                        .lastNameTextFieldValidator
                                    : HardcodedTextEng
                                        .lastNameTextFieldValidator;
                              } else if (value.length < 2) {
                                return isRtl
                                    ? HardcodedTextArabic
                                        .lastNameTextFieldValidator
                                    : HardcodedTextEng
                                        .lastNameTextFieldValidator;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.lastName = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: isRtl ? HardcodedTextArabic.strAddress1Text: HardcodedTextEng.strAddress1Text,
                              hintText: isRtl ? HardcodedTextArabic.strAddress1TextHint: HardcodedTextEng.strAddress1TextHint,
                            ),
                            initialValue: widget.initShipping?.address1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return isRtl ? HardcodedTextArabic.strAddress1TextValid: HardcodedTextEng.strAddress1TextValid;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.address1 = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: isRtl ? HardcodedTextArabic.strAddress2Text: HardcodedTextEng.strAddress2Text,
                              hintText: isRtl ? HardcodedTextArabic.strAddress1TextHint: HardcodedTextEng.strAddress1TextHint,
                            ),
                            initialValue: widget.initShipping?.address2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return isRtl ? HardcodedTextArabic.strAddress1TextValid: HardcodedTextEng.strAddress1TextValid;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.address2 = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: isRtl ? HardcodedTextArabic.cityTown: HardcodedTextEng.cityTown,
                              hintText: isRtl ? HardcodedTextArabic.cityTownHint: HardcodedTextEng.cityTownHint,
                            ),
                            initialValue: widget.initShipping?.city,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return isRtl ? HardcodedTextArabic.cityTownValid: HardcodedTextEng.cityTownValid ;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.city = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: isRtl ? HardcodedTextArabic.postcode: HardcodedTextEng.postcode,
                                    hintText: isRtl ? HardcodedTextArabic.postcodeHint: HardcodedTextEng.postcodeHint,
                                  ),
                                  initialValue: widget.initShipping?.postcode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return isRtl ? HardcodedTextArabic.postcodeValid: HardcodedTextEng.postcodeValid;
                                    } else if (value.length < 4) {
                                      return isRtl ? HardcodedTextArabic.postcodeValid: HardcodedTextEng.postcodeValid;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    shipping.postcode = value!;
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText:
                                    isRtl ? HardcodedTextArabic.state: HardcodedTextEng.state,
                                    hintText: isRtl ? HardcodedTextArabic.stateHint: HardcodedTextEng.stateHint,
                                  ),
                                  initialValue: widget.initShipping?.state,
                                  validator: (value) {
                                    return null;
                                  },
                                  onSaved: (value) {
                                    shipping.state = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: isRtl
                                  ? HardcodedTextArabic.textFieldPhoneLabel
                                  : HardcodedTextEng.textFieldPhoneLabel,
                              hintText: isRtl
                                  ? HardcodedTextArabic.textFieldPhoneHint
                                  : HardcodedTextEng.textFieldPhoneHint,
                            ),
                            initialValue: widget.initBilling?.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return isRtl
                                    ? HardcodedTextArabic
                                        .textFieldPhoneValidator
                                    : HardcodedTextEng.textFieldPhoneValidator;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.phone = value.toString();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Button1(
                        buttonText: isRtl ? HardcodedTextArabic.saveButton: HardcodedTextEng.saveButton,
                        buttonColor: primaryColor,
                        onPressFunction: () {
                          if (validateAndSave()) {
                            EasyLoading.show(
                                status: isRtl ? HardcodedTextArabic.updateHint: HardcodedTextEng.updateHint,);
                            retrieveCustomer.billing = Billing(
                              firstName: shipping.firstName ?? '',
                              lastName: shipping.lastName ?? '',
                              company: ' ',
                              address1: shipping.address1 ?? '',
                              address2: shipping.address2 ?? '',
                              city: shipping.city ?? '',
                              postcode: shipping.postcode ?? '',
                              country: shipping.country ?? '',
                              phone: shipping.phone ?? '',
                              email: ' ',
                              state: shipping.state ?? '',
                            );

                            retrieveCustomer.shipping = Shipping(
                              firstName: shipping.firstName ?? '',
                              lastName: shipping.lastName ?? '',
                              company: ' ',
                              address1: shipping.address1 ?? '',
                              address2: shipping.address2 ?? '',
                              city: shipping.city ?? '',
                              postcode: shipping.postcode ?? '',
                              country: shipping.country ?? '',
                              state: shipping.state ?? '',
                            );
                            apiService
                                .updateShippingAddress(retrieveCustomer)
                                .then((ret) {
                              if (ret) {
                                const CheckOutScreen()
                                    .launch(context, isNewTask: true);
                                EasyLoading.showSuccess(isRtl
                                    ? HardcodedTextArabic.easyLoadingSuccess
                                    : HardcodedTextEng.easyLoadingSuccess);
                              } else {
                                EasyLoading.showError(isRtl
                                    ? HardcodedTextArabic.easyLoadingError
                                    : HardcodedTextEng.easyLoadingError);
                              }
                            });
                          }
                        }),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    FormState form = globalKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
