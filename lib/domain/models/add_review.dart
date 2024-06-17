// To parse this JSON data, do
//
//     final addReview = addReviewFromJson(jsonString);

import 'dart:convert';

AddReview addReviewFromJson(String str) => AddReview.fromJson(json.decode(str));

String addReviewToJson(AddReview data) => json.encode(data.toJson());

class AddReview {
    AddReview({
        this.returnCode,
        this.data,
        this.returnMessage,
    });

    int ?returnCode;
    Data ?data;
    String? returnMessage;

    factory AddReview.fromJson(Map<String, dynamic> json) => AddReview(
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
        this.userId,
        this.doctorId,
        this.rating,
        this.review,
        this.id,
    });

    int ?userId;
    String ?doctorId;
    String ?rating;
    String ?review;
    int ?id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        rating: json["rating"],
        review: json["review"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "doctor_id": doctorId,
        "rating": rating,
        "review": review,
        "id": id,
    };
}
