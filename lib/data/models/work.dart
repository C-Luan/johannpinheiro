enum WorkCategory {
  captacao('Captação de Conteúdo'),
  corporativo('Eventos Corporativos'),
  esportivo('Eventos Esportivos'),
  institucional('Institucionais'),
  comercial('Comerciais');

  final String label;
  const WorkCategory(this.label);
}

class Work {
  final String id;
  final String title;
  final WorkCategory category;
  final int year;
  final String? driveId;

  const Work({
    required this.id,
    required this.title,
    required this.category,
    required this.year,
    this.driveId,
  });

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        id: json['id'] as String,
        title: json['title'] as String,
        category: WorkCategory.values.firstWhere((c) => c.name == json['category']),
        year: json['year'] as int,
        driveId: json['driveId'] as String?,
      );
}
