import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peanut_client_app/utils/dimension/dimen.dart';
import '../../core/base/base_consumer_state.dart';
import '../../core/di/core_provider.dart';
import '../../ui/common_text_widget.dart';
import '../../ui/custom_base_body_widget.dart';
import '../../utils/colors.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/pref_keys.dart';
import '../../utils/text_style.dart';
import '../login/login_screen.dart';


class MoreScreen extends ConsumerStatefulWidget {

  const MoreScreen({super.key});

  @override
  ConsumerState<MoreScreen> createState() => _MoreScreenState();

}

class _MoreScreenState extends BaseConsumerState<MoreScreen> {

  List<String> optionTitle = [
    'Profile',
    'Support',
    'Logout'
  ];

  List<IconData> iconList = [
    Icons.person,
    Icons.help_outline,
    Icons.logout
  ];

  Widget moreItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: DimenSizes.dimen_15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimenSizes.dimen_5),
      ),
      color: primaryWhite,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: DimenSizes.dimen_14,
            vertical: DimenSizes.dimen_4
        ),
        leading: Container(
          padding: const EdgeInsets.all(DimenSizes.dimen_8),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(DimenSizes.dimen_8),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        title: CommonTextWidget(
          text: title,
          style: semiBold14(color: primaryTextColor), // Switched to medium for better readability
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CommonTextWidget(text: "More",
              style: regular22(color: primaryWhite)
          )
      ),
      backgroundColor: bgPrimaryColor,
      body: CustomBaseBodyWidget(
        child: ListView.builder(
          itemCount: optionTitle.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return moreItem(
              title: optionTitle[index],
              icon: iconList[index],
              onTap: () {
               if(index == 2) {
                 DialogUtils.showCustomDialog(context,
                     isDismissible: true,
                     showCancelButton: true,
                     title: "Log Out",
                     content: "Are you sure you want to log out from your account?",
                     okBtnText: "YES",
                     cancelBtnText: "NO",
                     okBtnFunction: () {
                       ref.read(localPrefProvider).setBool(PrefKeys.isLoggedInKey, false);
                       ref.read(localPrefProvider).setString(PrefKeys.sessionTokenKey, "");
                       Navigator.pop(context);
                       Navigator.pushAndRemoveUntil(context,
                         MaterialPageRoute(builder: (context) => const LoginScreen()),
                             (route) => false,
                       );
                     }
                 );
                }
              },
            );
          },
        ),
      ),
    );
  }

}