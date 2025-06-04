class Application {
  final int id;
  final String title;
  final String icon;
  final int sort;
  final String? calculation_type;
  Application({
    required this.id,
    required this.title,
    required this.icon,
    required this.sort,
    this.calculation_type,
  });

  static Application fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] as int,
      title: json['title'].toString(),
      icon: json['icon'].toString(),
      sort: json['sort'] as int,
      calculation_type: json['calculation_type'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'sort': sort,
      'calculation_type': calculation_type
    };
  }
}

class Project {
  final int id;
  final String title;
  final String image;
  final int sort;
  Project({
    required this.id,
    required this.title,
    required this.image,
    required this.sort,
  });

  static Project fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      title: json['title'].toString(),
      image: json['image'].toString(),
      sort: json['sort'] as int,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'sort': sort,
    };
  }
}

class Product {
  final int id;
  final String title;
  final String? description;
  final String? image;
  final int? sandCoating;
  final String type;
  final int sort;
  final String? model;
  final String? project_model;
  final List<Application>? applications;
  final List<Project>? projects;

  Product({
    required this.id,
    required this.title,
    this.applications,
    this.projects,
    this.description,
    this.image,
    this.model,
    this.project_model,
    required this.sort,
    required this.type,
    this.sandCoating,
  });

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'].toString(),
      description: json['description'].toString(),
      applications: (json['applications'] as List)
          .map((app) => Application.fromJson(app))
          .toList(),
      projects: (json['projects'] as List)
          .map((app) => Project.fromJson(app))
          .toList(),
      image: json['image'].toString(),
      model: json['model'].toString(),
      project_model: json['project_model'].toString(),
      sandCoating: json['sand_coating'] as int,
      type: json['type'].toString(),
      sort: json['sort'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'model': model,
      'project_model': project_model,
      'sort': sort,
      'sandCoating': sandCoating,
      'type': type,
    };
  }
}
