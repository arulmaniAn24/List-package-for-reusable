import 'dart:convert';

UserPerference userPerferenceFromJson(String str) => UserPerference.fromJson(json.decode(str));

String userPerferenceToJson(UserPerference data) => json.encode(data.toJson());

class UserPerference {
    UserPreferences userPreferences;

    UserPerference({
        required this.userPreferences,
    });

    factory UserPerference.fromJson(Map<String, dynamic> json) => UserPerference(
        userPreferences: UserPreferences.fromJson(json["user_preferences"]),
    );

    Map<String, dynamic> toJson() => {
        "user_preferences": userPreferences.toJson(),
    };
}

class UserPreferences {
    String language;
    String theme;
    Notification notification;

    UserPreferences({
        required this.language,
        required this.theme,
        required this.notification,
    });

    factory UserPreferences.fromJson(Map<String, dynamic> json) => UserPreferences(
        language: json["language"],
        theme: json["theme"],
        notification: Notification.fromJson(json["notification"]),
    );

    Map<String, dynamic> toJson() => {
        "language": language,
        "theme": theme,
        "notification": notification.toJson(),
    };
}

class Notification {
    bool email;
    bool inApp;
    bool sms;

    Notification({
        required this.email,
        required this.inApp,
        required this.sms,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        email: json["email"],
        inApp: json["in_app"],
        sms: json["sms"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "in_app": inApp,
        "sms": sms,
    };
}
