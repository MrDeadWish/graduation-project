import 'package:binevir/data/models/measurement_system.dart';

class Country {
  final int id;
  final String code;
  final String title;
  final MeasurmentSystem measurement;

  Country({
    required this.id,
    required this.code,
    required this.title,
    required this.measurement,
  });

  static Country fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] as int,
      code: json['code'].toString(),
      title: json['title'].toString(),
      measurement: MeasurmentSystem.fromJson(json['measurement']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
    };
  }

  Country copy({
    int? id,
    String? code,
    String? title,
  }) {
    return Country(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      measurement: measurement,
    );
  }
}

class CountryItem {
  final String text;
  final int id;

  const CountryItem({
    required this.id,
    required this.text,
  });
}

getCountry(List countries, String countryCode) {
  var country;
  for (var element in countries) {
    if (element.code == countryCode) {
      country = element;
    }
  }
  return country;
}
