import 'field.dart';
import 'field_set.dart';
import 'field_set_error.dart';

abstract class FieldSetObject extends FieldSet {
  FieldSetObject(super.fields) : super.fromList() {
    final error = validate();
    if (error != null) {
      throw error;
    }
  }

  List<String> get requiredFields;

  FieldSetError? validate() {
    final missingFields = requiredFields.where((field) => !fields.containsKey(field)).toList();
    return missingFields.isNotEmpty
        ? FieldSetMissingFieldsError(missingFields: missingFields)
        : null;
  }
}

class Person extends FieldSetObject {
  static const kFirstName = 'firstName';
  static const kLastName = 'lastName';

  @override
  List<String> get requiredFields => [kFirstName, kLastName];

  Person({required String firstName, required String lastName})
    : super([Field(name: kFirstName, value: firstName), Field(name: kLastName, value: lastName)]);

  String get firstName => fields[kFirstName]?.value as String;
  String get lastName => fields[kLastName]?.value as String;
}
