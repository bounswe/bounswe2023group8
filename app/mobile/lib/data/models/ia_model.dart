class IaModel {
  final int id;
  final String areaName;

  const IaModel({
    required this.id,
    required this.areaName,
  });

  factory IaModel.fromJson(Map<String, dynamic> json) {
    return IaModel(
      id: json['id'],
      areaName: json['area_name'],
    );
  }
}
