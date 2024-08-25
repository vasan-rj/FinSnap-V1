
class customNotification 
{
  String title;
  String description;
  DateTime timeDate;
  DateTime createdAt;
  DateTime updateAt;
  bool isRead;
  String notificationType;

  customNotification(
      {required this.title,
      required this.description,
      required this.timeDate,
      required this.createdAt,
      required this.isRead,
      required this.updateAt,
      required this.notificationType,
      });

  customNotification.fromJson(Map<String, Object?> json)
      : this(
            title: json['title']! as String,
            description: json['description'] as String,
            timeDate: json['timeDate'] as DateTime,
            createdAt: json['createdAt'] as DateTime,
            updateAt: json['updateAt'] as DateTime,
            isRead: json['isRead'] as bool,
            notificationType: json['notificationType'] as String,
            );

  customNotification copyWith({
      String? title,
      String? description,
      DateTime? timeDate,
      DateTime? createdAt,
      DateTime? updateAt,
      bool? isRead,
      String? notificationType
      })
    {
      return customNotification(
        title: title ?? this.title,
        description: description ?? this.description,
        timeDate: timeDate ?? this.timeDate,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        isRead: isRead ?? this.isRead,
        notificationType: notificationType ?? this.notificationType
        );
    }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'timeDate': timeDate,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'isRead': isRead,
      'notificationType':notificationType

    };
      }
      
}
