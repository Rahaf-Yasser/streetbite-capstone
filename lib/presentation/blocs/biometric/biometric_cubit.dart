import 'package:flutter_app/domain/entities/biometric_result.dart';
import 'package:flutter_app/domain/usecases/authenticate_with_biometrics_usecase.dart';
import 'package:flutter_app/presentation/blocs/biometric/biometric_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricCubit extends Cubit<BiometricState> {
  final AuthenticateWithBiometricsUseCase _authenticate;

  BiometricCubit(this._authenticate) : super(const BiometricInitial());

  Future<void> authenticate(String reason) async {
    if (state is BiometricInProgress) return;
    emit(const BiometricInProgress());
    final result = await _authenticate(reason);
    emit(
      result == BiometricResult.success
          ? const BiometricSuccess()
          : BiometricFailure(result),
    );
  }
}