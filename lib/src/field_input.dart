import 'field.dart';

abstract class FieldInput<T, E extends FieldInputError> extends Field<T?> {
  const FieldInput._({required super.name, required super.value, this.isPure = true});

  /// Constructor which create a `pure` [FieldInput] with a given value.
  const FieldInput.pure(String name, T value) : this._(name: name, value: value);

  /// Constructor which create a `dirty` [FieldInput] with a given value.
  const FieldInput.dirty(String name, T value) : this._(name: name, value: value, isPure: false);

  @override
  FieldInput<T, E> copyWith({T? value, bool? isPure});

  Field<T?> toField() => Field(name: name, value: value);

  /// If the [FieldInput] is pure (has not been touched/modified).
  /// Typically when the `FieldInput` is initially created,
  /// it is created using the `FieldInput.pure` constructor to
  /// signify that the user has not modified it.
  ///
  /// For subsequent changes (in response to user input), the
  /// `FieldInput.dirty` constructor should be used to signify that
  /// the `FieldInput` has been manipulated.
  final bool isPure;

  /// Whether the [FieldInput] value is valid according to the
  /// overridden `validator`.
  ///
  /// Returns `true` if `validator` returns `null` for the
  /// current [FieldInput] value and `false` otherwise.
  bool get isValid => validator(value) == null;

  /// Whether the [FieldInput] value is not valid.
  /// A value is invalid when the overridden `validator`
  /// returns an error (non-null value).
  bool get isNotValid => !isValid;

  /// Returns a validation error if the [FieldInput] is invalid.
  /// Returns `null` if the [FieldInput] is valid.
  E? get error => validator(value);

  /// The error to display if the [FieldInput] value
  /// is not valid and has been modified.
  E? get displayError => isPure ? null : error;

  /// A function that must return a validation error if the provided
  /// [value] is invalid and `null` otherwise.
  E? validator(T? value);

  @override
  List<Object?> get props => [name, value, isPure];
}

class RequiredFieldInput<T, E extends RequiredFieldInputError> extends FieldInput<T, E> {
  const RequiredFieldInput._({required super.name, required super.value, required super.isPure})
    : super._();
  const RequiredFieldInput.pure(super.name, super.value) : super.pure();
  const RequiredFieldInput.dirty(super.name, super.value) : super.dirty();

  @override
  FieldInput<T, E> copyWith({T? value, bool? isPure}) =>
      RequiredFieldInput._(name: name, value: value ?? this.value, isPure: isPure ?? this.isPure);

  @override
  E? validator(T? value) => value == null ? const RequiredFieldInputError() as E : null;
}

class FieldInputError {
  const FieldInputError([this.message = 'Invalid input']);
  final String message;
}

class RequiredFieldInputError extends FieldInputError {
  const RequiredFieldInputError([super.message = 'This field is required']);
}
