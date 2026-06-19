class Log {
  final String id;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime? endTime;
  final int? effort;
  final bool isImportant;
  final String? tag;
  final DateTime createdAt;

  Log({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    this.endTime,
    this.effort,
    required this.isImportant,
    this.tag,
    required this.createdAt,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startTime: DateTime.parse(json['start_time']),
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'])
          : null,
      effort: json['effort'],
      isImportant: json['is_important'],
      tag: json['tag'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'effort': effort,
      'is_important': isImportant,
      'tag': tag,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
