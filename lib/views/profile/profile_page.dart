import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:zapizza/common/custom_button.dart';
import 'package:zapizza/common/custom_container.dart';
import 'package:zapizza/controllers/login_controller.dart';
import 'package:zapizza/models/login_response.dart';
import 'package:zapizza/views/auth/login_redirect.dart';
import 'package:zapizza/views/auth/verification_page.dart';
import 'package:zapizza/views/orders/user_orders.dart';
import 'package:zapizza/views/profile/addresses_page.dart';
import 'package:zapizza/views/profile/widget/profile_app_bar.dart';
import 'package:zapizza/constants/constants.dart';
import 'package:zapizza/views/profile/widget/profile_tile_widget.dart';
import 'package:zapizza/views/profile/widget/user_info_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controller = Get.put(LoginController());

    final box = GetStorage();

    String? token = box.read('token');

    if (token != null) {
      user = controller.getUserInfo();
    }

    if (token == null) {
      return const LoginRedirect();
    }

    if (user != null && user.verification == false) {
      return const VerificationPage();
    }

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.h), child: const ProfileAppBar()),
      body: SafeArea(
        child: CustomContainer(
            containerContent: Column(
          children: [
            UserInfoWidget(user: user),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 175.h,
              decoration: const BoxDecoration(color: kLightWhite),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileTileWidget(
                      onTap: () {
                        Get.to(() => const UserOrders(),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 900));
                      },
                      title: "My Orders",
                      icon: Ionicons.fast_food_outline),
                  ProfileTileWidget(
                      onTap: () {},
                      title: "My Favorite Places",
                      icon: Ionicons.heart_outline),
                  ProfileTileWidget(
                      onTap: () {},
                      title: "Review",
                      icon: Ionicons.chatbubble_outline),
                  ProfileTileWidget(
                      onTap: () {},
                      title: "Coupons",
                      icon: MaterialCommunityIcons.tag_outline),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 175.h,
              decoration: const BoxDecoration(color: kLightWhite),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ProfileTileWidget(
                      onTap: () {
                        Get.to(() => const Addresses(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 900));
                      },
                      title: "Shipping Address",
                      icon: SimpleLineIcons.location_pin),
                  ProfileTileWidget(
                      onTap: () {},
                      title: "Sevice Center",
                      icon: AntDesign.customerservice),
                  ProfileTileWidget(
                      onTap: () {},
                      title: "Coupons",
                      icon: MaterialIcons.rss_feed),
                  ProfileTileWidget(
                      onTap: () {}, title: "Settings", icon: AntDesign.setting),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              onTap: () {
                controller.logout();
              },
              btnColor: kRed,
              text: "Logout",
              radius: 0,
            )
          ],
        )),
      ),
    );
  }
}
