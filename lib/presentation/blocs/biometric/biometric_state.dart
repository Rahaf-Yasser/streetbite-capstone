import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/biometric_result.dart';

abstract class BiometricState extends Equatable {
  const BiometricState();

  @override
  List<Object?> get props => [];
}

class BiometricInitial extends BiometricState {
  const BiometricInitial();
}

class BiometricInProgress extends BiometricState {
  const BiometricInProgress();
}

class BiometricSuccess extends BiometricState {
  const BiometricSuccess();
}

class BiometricFailure extends BiometricState {
  final BiometricResult result;
  const BiometricFailure(this.result);

  @override
  List<Object?> get props => [result];
}