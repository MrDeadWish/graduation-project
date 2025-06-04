class SheetSize {
  final int id;
  final String name;
  final int sort;

  SheetSize({
    required this.id,
    required this.name,
    required this.sort,
  });

  static SheetSize fromJson(Map<String, dynamic> json) {
    return SheetSize(
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

  SheetSize copy({
    int? id,
    String? name,
    int? sort,
  }) {
    return SheetSize(
      id: id ?? this.id,
      name: name ?? this.name,
      sort: sort ?? this.sort,
    );
  }
}
