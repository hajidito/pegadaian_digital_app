class AbsencesRequest {
  AbsencesRequest({
    required this.userId,
    required this.latitude,
    required this.longitude,
  });

  final String? userId;
  final String? latitude;
  final String? longitude;

  factory AbsencesRequest.fromJson(Map<String, dynamic> json) {
    return AbsencesRequest(
      userId: json["user_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "latitude": latitude,
        "longitude": longitude,
      };
}
