import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_app/presentation/screens/sign_up_screen.dart';
import 'package:flutter_app/presentation/screens/login_screen.dart';
import 'package:flutter_app/core/navigation/fade_route.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_app/presentation/screens/main_shell.dart';
import 'package:flutter_app/presentation/widgets/language_toggle_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward().whenComplete(_checkSession);
  }

    Future<void> _checkSession() async {
    final cubit = context.read<AuthCubit>();
    await cubit.checkAuthStatus();
    if (!mounted) return;
    final state = cubit.state;
    if (state is Authenticated) {
      Navigator.of(context).pushAndRemoveUntil(
        fadeRoute(const MainShell()),
        (route) => false,
      );
    }
  }

  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.inputFill,
      body: FadeTransition(
        opacity: _opacity,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Positioned.fill(child: _buildHero()),
                      const PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: LanguageToggleButton(),
                          ),
                        ),
                      ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.welcomeHeadline,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.welcomeSubtext,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 28),
                    _buildButton(
                      l10n.signUpButton,
                      () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildButton(
                      l10n.logInButton,
                      () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.lightGreen,
          foregroundColor: AppTheme.primary,
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)],
      ),
      child: const Icon(Icons.fastfood, size: 48, color: AppTheme.primary),
    );
  }

  Widget _buildHero() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/welcome_bg.jpg', fit: BoxFit.cover),
        Center(child: _buildBadge()),
      ],
    );
  }
}