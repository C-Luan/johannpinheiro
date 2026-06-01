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
  final String? embedUrl;
  final String? thumbnailUrl;

  const Work({
    required this.id,
    required this.title,
    required this.category,
    required this.year,
    this.embedUrl,
    this.thumbnailUrl,
  });
}
