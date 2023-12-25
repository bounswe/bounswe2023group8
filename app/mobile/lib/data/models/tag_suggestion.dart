class TagSuggestion {
  final int id;
  final String wikiDataTagId;
  final String label;
  final String description;
  final bool isValidTag;
  final int requesterCount;

  TagSuggestion({
    required this.id,
    required this.wikiDataTagId,
    required this.label,
    required this.description,
    required this.isValidTag,
    required this.requesterCount,
  });

  factory TagSuggestion.fromJson(Map<String, dynamic> json) {
    return TagSuggestion(
      id: json['id'] ?? 0,
      wikiDataTagId: json['wikiDataTagId'] ?? '',
      label: json['label'] ?? '',
      description: json['description'] ?? '',
      isValidTag: json['isValidTag'] ?? false,
      requesterCount: json['requesterCount'] ?? 0,
    );
  }
}
