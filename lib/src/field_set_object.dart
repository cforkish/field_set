import 'field.dart';
import 'field_set.dart';
import 'field_set_error.dart';

/// Example template for creating a [FieldSetObject] subclass.
///
/// Replace the class name, static field names, required fields, constructor, and getters
/// with those corresponding to your data model.
///
/// ```dart
/// class YourObject extends FieldSetObject {
///   static const kField1 = 'field1';
///   static const kField2 = 'field2';
///
///   @override
///   List<String> get requiredFields => [kField1, kField2];
///
///   YourObject({required String field1, required String field2})
///     : super([
///         Field(name: kField1, value: field1),
///         Field(name: kField2, value: field2),
///       ]);
///
///   String get field1 => fields[kField1]?.value as String;
///   String get field2 => fields[kField2]?.value as String;
/// }
/// ```
abstract class FieldSetObject extends FieldSet {
  FieldSetObject(super.fields) : super.fromList() {
    final error = validate();
    if (error != null) {
      throw error;
    }
  }

  static T fromFields<T extends FieldSetObject>(List<Field> fields) {
    final T object = FieldSet.fromList(fields) as T;
    return object;
  }

  List<String> get requiredFields => [];

  bool get isValid => validate() == null;

  FieldSetError? validate() {
    final missingFields = requiredFields.where((field) => !fields.containsKey(field)).toList();
    return missingFields.isNotEmpty
        ? FieldSetMissingFieldsError(missingFields: missingFields)
        : null;
  }
}
