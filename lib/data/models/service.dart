class Service {
  final int order;
  final String title;
  final String description;
  final bool featured;

  const Service({
    required this.order,
    required this.title,
    required this.description,
    this.featured = false,
  });
}
