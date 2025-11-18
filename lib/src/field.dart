import 'package:equatable/equatable.dart';

class Field<T> extends Equatable {
  const Field({required this.name, required this.value});
  final String name;
  final T value;

  Field<T> copyWith({T? value}) => Field(name: name, value: value ?? this.value);

  Map<String, dynamic> toJson() => {name: value};

  @override
  List<Object?> get props => [name, value];
}
