import 'dart:convert';

GetNotesResponse getNotesResponseFromJson(String str) =>
    GetNotesResponse.fromJson(json.decode(str));

class GetNotesResponse {
  GetNotesResponse({
    this.returnCode,
    this.returnMessage,
    this.shared,
    this.myNotes,
  });
  int? returnCode;
  String? returnMessage;
  List<SharedNotes>? shared;
  List<MyNotes>? myNotes;

  factory GetNotesResponse.fromJson(Map<String, dynamic> json) =>
      GetNotesResponse(
        returnCode: json['returnCode'],
        returnMessage: json['returnMessage'],
        shared: List<SharedNotes>.from(
            json["data"]['shared'].map((x) => SharedNotes.fromJson(x))),
        myNotes: List<MyNotes>.from(
            json["data"]['mynotes'].map((x) => MyNotes.fromJson(x))),
      );
}

class SharedNotes {
  SharedNotes(
      {this.id,
      this.title,
      this.description,
      this.createdTime,
      this.dateTime,
      this.files,
      this.users});
  int? id;
  String? title;
  String? description;
  String? createdTime;
  String? dateTime;
  String? files;
  dynamic users;

  factory SharedNotes.fromJson(Map<String, dynamic> json) => SharedNotes(
        id: json['id'],
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        createdTime: json['created_at'],
        dateTime: json['datetime'] as String? ?? '',
        users: json['users'] ?? '',
        files: json['files'] as String? ?? '',
      );
}

class MyNotes {
  MyNotes(
      {this.id,
      this.title,
      this.description,
      this.createdTime,
      this.dateTime,
      this.files,
      this.users});
  int? id;
  dynamic users;
  String? title;
  String? description;
  String? createdTime;
  String? dateTime;
  String? files;

  factory MyNotes.fromJson(Map<String, dynamic> json) => MyNotes(
        id: json['id'],
        title: json['title'],
        users: json['users'],
        description: json['description'],
        createdTime: json['created_at'],
        dateTime: json['datetime'],
        files: json['files'],
      );
}
