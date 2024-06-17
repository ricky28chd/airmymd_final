import 'dart:convert';

AddNoteResponse addNoteResponseFromJson(String str) =>
    AddNoteResponse.fromJson(json.decode(str));

class AddNoteResponse {
  AddNoteResponse({
    this.returnCode,
    this.returnMessage,
  });
  int? returnCode;
  String? returnMessage;

  factory AddNoteResponse.fromJson(Map<String, dynamic> json) =>
      AddNoteResponse(
        returnCode: json['returnCode'],
        returnMessage: json['returnMessage'],
      );
}
