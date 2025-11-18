abstract class FieldSetError extends Error {
  FieldSetError({required this.message});
  final String message;
}

class FieldSetMissingFieldsError extends FieldSetError {
  FieldSetMissingFieldsError({required this.missingFields})
    : super(message: 'FieldSetObject: Missing required fields [${missingFields.join(', ')}]');
  final List<String> missingFields;
}
