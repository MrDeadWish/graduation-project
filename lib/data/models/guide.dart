class Guide {
  final int id;
  final String image;
  final String? title;
  final String? description;
  final int sort;

  Guide({
    required this.id,
    required this.image,
    this.title,
    this.description,
    required this.sort,
  });

  static Guide fromJson(Map<String, dynamic> json) {
    return Guide(
      id: json['id'] as int,
      image: json['image'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      sort: json['sort'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'sort': sort
    };
  }

  Guide copy({
    int? id,
    String? title,
    String? image,
    String? description,
    int? sort,
  }) {
    return Guide(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      sort: sort ?? this.sort,
    );
  }
}
