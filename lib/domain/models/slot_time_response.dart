// To parse this JSON data, do
//
//     final slotTimeResponse = slotTimeResponseFromJson(jsonString);

import 'dart:convert';

SlotTimeResponse slotTimeResponseFromJson(String str) =>
    SlotTimeResponse.fromJson(json.decode(str));

String slotTimeResponseToJson(SlotTimeResponse data) =>
    json.encode(data.toJson());

class SlotTimeResponse {
  SlotTimeResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory SlotTimeResponse.fromJson(Map<String, dynamic> json) =>
      SlotTimeResponse(
        returnCode: json["returnCode"],
        data: Data.fromJson(json["data"]),
        returnMessage: json["returnMessage"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": data!.toJson(),
        "returnMessage": returnMessage,
      };
}

class Data {
  Data({
    this.slotStartTime,
  });

  List<String>? slotStartTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slotStartTime: List<String>.from(json["slot_start_time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "slot_start_time": List<dynamic>.from(slotStartTime!.map((x) => x)),
      };
}
