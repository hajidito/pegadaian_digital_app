class UpdateAbsencesRequest {
  UpdateAbsencesRequest({
    required this.latitude,
    required this.longitude,
  });

  final String? latitude;
  final String? longitude;

  factory UpdateAbsencesRequest.fromJson(Map<String, dynamic> json) {
    return UpdateAbsencesRequest(
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
