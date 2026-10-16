import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/fade_route.dart';
import 'package:flutter_app/core/utils/auth_error_message.dart';
import 'package:flutter_app/core/utils/validators.dart';
import 'package:flutter_app/l10n/app_localizations.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_app/presentation/screens/main_shell.dart';
import 'package:flutter_app/presentation/widgets/app_text_field.dart';
import 'package:flutter_app/presentation/widgets/auth_form_scaffold.dart';
import 'package:flutter_app/presentation/widgets/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().logIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            fadeRoute(const MainShell()),
            (route) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authErrorMessage(state.type, state.message, l10n)),
            ),
          );
        }
      },
      builder: (context, state) {
        return AuthFormScaffold(
          title: l10n.logInTitle,
          formKey: _formKey,
          children: [
            AppTextField(
              controller: _emailController,
              label: l10n.emailLabel,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => Validators.email(v, l10n),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _passwordController,
              label: l10n.passwordLabel,
              isPassword: true,
              validator: (v) => Validators.password(v, l10n),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: l10n.logInButton,
              isLoading: state is AuthLoading,
              onPressed: _submit,
            ),
          ],
        );
      },
    );
  }
}