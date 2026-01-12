class TaskModel {
  TaskModel({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.date,
    this.isCompleted = false,
  });
  String? id;
  String? title;
  String? description;
  int? priority;
  DateTime? date;
  bool? isCompleted;

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    int? priority,
    DateTime? date,
    bool? isCompleted,
  }) => TaskModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    priority: priority ?? this.priority,
    date: date ?? this.date,
    isCompleted: isCompleted ?? this.isCompleted,
  );

  TaskModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      priority = json['priority'],
      date = DateTime.fromMillisecondsSinceEpoch(json['date']),
      isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority,
    'date': DateTime(
      date!.year,
      date!.month,
      date!.day,
      date!.hour,
      date!.minute,
      date!.second,
    ).millisecondsSinceEpoch,
    'isCompleted': isCompleted,
  };
}
