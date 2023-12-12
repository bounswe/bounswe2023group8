class WikiTag {
  final String id;
  final String label;
  final String description;
  final bool isValidTag;

  WikiTag({
    required this.id,
    required this.label,
    required this.description,
    required this.isValidTag,
  });

  factory WikiTag.fromJson(Map<String, dynamic> json) {
    return WikiTag(
      id: json['id'] ?? '',
      label: json['label'] ?? '',
      description: json['description'] ?? '',
      isValidTag: json['isValidTag'] ?? false,
    );
  }

  factory WikiTag.fromWikiResponse(Map<String, dynamic> json) {
    final display = json['display'];
    final label = display['label'];
    final description = display['description'];

    return WikiTag(
      id: json['id'] ?? '',
      label: label['value'] ?? '',
      description: description['value'] ?? '',
      isValidTag: true,
    );
  }
}
