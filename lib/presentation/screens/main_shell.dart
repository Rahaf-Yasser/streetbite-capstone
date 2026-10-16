import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/browse_screen.dart';
import 'package:flutter_app/presentation/screens/home_screen.dart';
import 'package:flutter_app/presentation/screens/orders_screen.dart';
import 'package:flutter_app/presentation/screens/profile_screen.dart';
import 'package:flutter_app/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:flutter_app/presentation/widgets/profile_access_listener.dart';

/// Owns the bottom bar and shows one of the four main screens.
/// The Profile tab is only built after the fingerprint check succeeds,
/// and it is removed again when the user leaves it, so every visit
/// asks for the fingerprint again.
class MainShell extends StatefulWidget {

  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = AppBottomNavBar.homeIndex;

  Widget _buildPage() {
    switch (_index) {
      case AppBottomNavBar.browseIndex:
        return const BrowseScreen();
      case AppBottomNavBar.ordersIndex:
        return const OrdersScreen();
      case AppBottomNavBar.profileIndex:
        return const ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileAccessListener(
      onUnlocked: () =>
          setState(() => _index = AppBottomNavBar.profileIndex),
      child: Builder(
        builder: (context) => PopScope(
          // Android back: from any other tab, go to Home instead of exiting.
          canPop: _index == AppBottomNavBar.homeIndex,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              setState(() => _index = AppBottomNavBar.homeIndex);
            }
          },
          child: Scaffold(
            body: _buildPage(),
            bottomNavigationBar: AppBottomNavBar(
              currentIndex: _index,
              onTabSelected: (index) {
                if (index == _index) return;
                if (index == AppBottomNavBar.profileIndex) {
                  ProfileAccessListener.start(context);
                } else {
                  setState(() => _index = index);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}