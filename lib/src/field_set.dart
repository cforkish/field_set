import 'package:equatable/equatable.dart';

import 'field.dart';

class FieldSet extends Equatable {
  const FieldSet._(this.fields);

  FieldSet.fromMap(Map<String, Field> fields) : this._(Map.unmodifiable(fields));
  FieldSet.fromList(List<Field> fields)
    : this._(Map.unmodifiable({for (var field in fields) field.name: field}));

  final Map<String, Field> fields;

  FieldSet copyWith({List<Field>? fields}) {
    if (fields == null || fields.isEmpty) {
      return this;
    }
    return FieldSet.fromMap(mergeFields(newFields: fields, existingFields: this.fields));
  }

  @override
  List<Object?> get props => [fields];

  static Map<String, Field> mergeFields({
    required List<Field> newFields,
    required Map<String, Field> existingFields,
  }) {
    for (var field in newFields) {
      if (!existingFields.containsKey(field.name)) {
        throw ArgumentError('Cannot update field "${field.name}": field does not exist in map');
      }
    }
    return {...existingFields, for (var field in newFields) field.name: field};
  }
}
