import 'package:flutter/material.dart';

/// Page layout shared by Sign Up and Login: app bar, scrolling form and title.
/// RESPONSIVE: the padding follows the screen width (MediaQuery) and the
/// form is capped at 480 px, so it stays readable on tablets and in landscape.
class AuthFormScaffold extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const AuthFormScaffold({
    super.key,
    required this.title,
    required this.formKey,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final padding = (width * 0.06).clamp(16.0, 32.0);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}