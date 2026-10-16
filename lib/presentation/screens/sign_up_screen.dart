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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  /// Shows the success dialog, then fades to the main screen.
  Future<void> _showSuccessDialog() async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.signUpSuccessTitle),
        content: Text(l10n.signUpSuccessMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.continueButton),
          ),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      fadeRoute(const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          _showSuccessDialog();
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
          title: l10n.signUpTitle,
          formKey: _formKey,
          children: [
            AppTextField(
              controller: _nameController,
              label: l10n.fullNameLabel,
              textCapitalization: TextCapitalization.words,
              validator: (v) => Validators.fullName(v, l10n),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            AppTextField(
              controller: _confirmController,
              label: l10n.confirmPasswordLabel,
              isPassword: true,
              validator: (v) => Validators.confirmPassword(
                v,
                _passwordController.text,
                l10n,
              ),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: l10n.signUpButton,
              isLoading: state is AuthLoading,
              onPressed: _submit,
            ),
          ],
        );
      },
    );
  }
}