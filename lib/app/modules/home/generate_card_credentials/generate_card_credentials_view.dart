import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../data/resources/size_config.dart';
import '../../../data/utils/widgets.dart';
import 'generate_card_credentials_controller.dart';

class GenerateCardCredentialsView
    extends GetView<GenerateCardCredentialsController> {
  const GenerateCardCredentialsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCommonAppBar(
          text: "save card", onButtonPressed: controller.insertCardToDB),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              child: Form(
                key: controller.formKey,
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration:
                        getCommonInputDecoration("Title", hintText: "Untitled")
                            .copyWith(
                      hintStyle: titleTextStyle,
                    ),
                    style: titleTextStyle,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "title must not be empty";
                      }
                      return null;
                    },
                    controller: controller.titleController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: getCommonInputDecoration("name on card",
                            hintText: "Full name")
                        .copyWith(
                            prefixIcon:
                                const Icon(Icons.person_outline_rounded)),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "name is required";
                      }
                      return null;
                    },
                    controller: controller.nameOnCardController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CreditCardNumberInputFormatter(
                            onCardSystemSelected: (value) {
                          controller.cardSystemData.value = value;
                        }),
                        if (controller.cardSystemData.value != null)
                          MaskedInputFormatter(
                            controller.cardSystemData.value!.numberMask!,
                          ),
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: getCommonInputDecoration("Card number",
                              hintText: "0000 0000 0000 0000")
                          .copyWith(
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        errorMaxLines: 2,
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "card number required";
                        } else if (!isCardNumberValid(cardNumber: text)) {
                          return "card number not valid";
                        }
                        return null;
                      },
                      controller: controller.cardNumberController,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CreditCardExpirationDateFormatter(),
                    ],
                    textInputAction: TextInputAction.next,
                    decoration: getCommonInputDecoration("Expiration date",
                            hintText: "00/00")
                        .copyWith(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      errorMaxLines: 2,
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Expiration date required";
                      }
                      return null;
                    },
                    controller: controller.expDateController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CreditCardCvcInputFormatter(),
                    ],
                    textInputAction: TextInputAction.next,
                    decoration:
                        getCommonInputDecoration("cvv code", hintText: "000")
                            .copyWith(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      errorMaxLines: 2,
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "code is required";
                      }
                      return null;
                    },
                    controller: controller.cvvController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textInputAction: TextInputAction.next,
                    decoration:
                        getCommonInputDecoration("ATM pin", hintText: "000")
                            .copyWith(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      errorMaxLines: 2,
                    ),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "atm pin required";
                      } else if (text.length < 4 || text.length == 5) {
                        return "atm pin not valid";
                      }
                      return null;
                    },
                    controller: controller.cardPinController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: getCommonInputDecoration("Note").copyWith(
                        prefixIcon: const Icon(Icons.sticky_note_2_rounded)),
                    controller: controller.noteController,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
