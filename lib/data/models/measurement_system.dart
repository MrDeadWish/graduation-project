class MeasurmentSystem {
  final int id;
  final String name;
  final int sort;

  MeasurmentSystem({
    required this.id,
    required this.name,
    required this.sort,
  });

  static MeasurmentSystem fromJson(Map<String, dynamic> json) {
    return MeasurmentSystem(
      id: json['id'] as int,
      name: json['name'].toString(),
      sort: json['sort'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sort': sort,
    };
  }

  MeasurmentSystem copy({
    int? id,
    String? name,
    int? sort,
  }) {
    return MeasurmentSystem(
      id: id ?? this.id,
      name: name ?? this.name,
      sort: sort ?? this.sort,
    );
  }
}

class MeasurmentSystemItem {
  final String name;
  final int id;
  final int sort;

  const MeasurmentSystemItem({
    required this.name,
    required this.id,
    required this.sort,
  });
}
