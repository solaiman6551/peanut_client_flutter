import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/base/base_consumer_state.dart';
import '../../core/di/core_provider.dart';
import '../../ui/common_text_widget.dart';
import '../../ui/custom_base_body_widget.dart';
import '../../utils/colors.dart';
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

  Widget container({
    required String title,
    required IconData icon,
    required VoidCallback onTap
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: Colors.blue),
          ),
          title: CommonTextWidget(
            text: title,
            style: regular14(),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: onTap,
        ),
        const Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: CustomBaseBodyWidget(
        child: ListView.builder(
          itemCount: optionTitle.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return container(
              title: optionTitle[index],
              icon: iconList[index],
              onTap: () {
               if(index == 2) {
                  ref.read(localPrefProvider).setBool(PrefKeys.isLoggedInKey, false);
                  ref.read(localPrefProvider).setString(PrefKeys.sessionTokenKey, "");
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
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