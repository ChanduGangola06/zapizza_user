import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zapizza/common/app_style.dart';
import 'package:zapizza/common/back_ground_container.dart';
import 'package:zapizza/common/custom_button.dart';
import 'package:zapizza/common/reusable_text.dart';
import 'package:zapizza/common/shimmers/foodlist_shimmer.dart';
import 'package:zapizza/constants/constants.dart';
import 'package:zapizza/hooks/fetch_address.dart';
import 'package:zapizza/models/addresses_response.dart';
import 'package:zapizza/views/profile/shipping_address.dart';
import 'package:zapizza/views/profile/widget/address_list.dart';
import 'package:get/get.dart';

class Addresses extends HookWidget {
  const Addresses({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAddresses();

    final List<AddressResponse> addresses = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        title: ReusableText(
          text: "Addresses",
          style: appStyle(13, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        color: kOffWhite,
        child: Stack(
          children: [
            isLoading
                ? const FoodsListShimmer()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: AddressListWidget(addresses: addresses),
                  ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 30.h),
                child: CustomButton(
                  onTap: () {
                    Get.to(() => const ShippingAddress());
                  },
                  text: "Add Address",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
