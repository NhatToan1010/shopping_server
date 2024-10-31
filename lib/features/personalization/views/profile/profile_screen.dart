import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/personalization/views/profile/widgets/profile_avatar.dart';
import 'package:shopping_server/features/personalization/views/profile/widgets/profile_detail.dart';
import 'package:shopping_server/utils/constants/sizes.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(title: Text('Profile'), showBackArrow: true,),
      
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSpace),
            child: Column(
              children: [
                // ----- Avatar
                ProfileAvatar(),
      
                // ----- Details
                ProfileDetail(),
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}



