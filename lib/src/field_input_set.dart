import 'package:equatable/equatable.dart';

import 'field_input.dart';
import 'field_set.dart';

class FieldInputSet extends Equatable {
  const FieldInputSet._(this.inputs);

  FieldInputSet.fromMap(Map<String, FieldInput> inputs) : this._(Map.unmodifiable(inputs));

  FieldInputSet.fromList(List<FieldInput> inputs)
    : this._(Map.unmodifiable({for (var input in inputs) input.name: input}));

  final Map<String, FieldInput> inputs;

  FieldSet toFieldSet() =>
      FieldSet.fromList(inputs.values.map((input) => input.toField()).toList());

  FieldInputSet copyWith({List<FieldInput>? inputs}) {
    if (inputs == null || inputs.isEmpty) {
      return this;
    }
    return FieldInputSet.fromMap(
      FieldSet.mergeFields(newFields: inputs, existingFields: this.inputs)
          as Map<String, FieldInput>,
    );
  }

  @override
  List<Object?> get props => [inputs];

  bool get isValid => inputs.values.every((input) => input.isValid);

  String? get validationErrorMessage {
    final errors = inputs.values.map((input) => input.displayError?.message).nonNulls.join('\n');
    return errors.isEmpty ? null : errors;
  }
}
