import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peanut_client_app/module/home/home_screen.dart';
import '../../core/base/base_consumer_state.dart';
import '../../utils/assets_provider.dart';
import '../../utils/colors.dart';
import '../../utils/dimen.dart';
import '../more/more_screen.dart';
import '../open_trades/open_trades_screen.dart';


class DashboardScreen extends ConsumerStatefulWidget {

  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();

}

final dashboardIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});


class _DashboardScreenState extends BaseConsumerState<DashboardScreen> {

  final _screens = [
    const HomeScreen(),
    const OpenTradesScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final currentIndex = ref.watch(dashboardIndexProvider);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: primaryWhite,
            notchMargin: DimenSizes.dimen_8,
            clipBehavior: Clip.antiAlias,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(DimenSizes.dimen_10),
                topRight: Radius.circular(DimenSizes.dimen_10),
              ),
              child: BottomNavigationBar(
                backgroundColor: primaryWhite,
                currentIndex: ref.watch(dashboardIndexProvider),
                selectedItemColor: primaryColor,
                unselectedFontSize: 12,
                selectedIconTheme: IconThemeData(color: primaryColor, opacity: DimenSizes.dimen_1, size: DimenSizes.dimen_30),
                unselectedIconTheme: IconThemeData(color: primaryRedColor, opacity: DimenSizes.dimen_1, size: DimenSizes.dimen_30),
                onTap: (index) {
                  ref.read(dashboardIndexProvider.notifier).state = index;
                },
                items: [
                  _buildNavItem('ic_dash_home', 'Home', 0, currentIndex),
                  _buildNavItem('ic_dash_traders', 'Traders', 1, currentIndex),
                  _buildNavItem('ic_dash_more', 'More', 2, currentIndex),
                ],
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            )
        ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconName, String label, int index, int activeIndex) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        AssetsProvider.svgPath(iconName),
        colorFilter: ColorFilter.mode(
          activeIndex == index ? primaryColor : lightGreyColor,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }


}