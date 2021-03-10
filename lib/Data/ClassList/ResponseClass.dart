class ResponseDataClass {
  String Message;
  bool IsSuccess;
  String Data;

  ResponseDataClass({this.Message, this.IsSuccess, this.Data});

  factory ResponseDataClass.fromJson(Map<String, dynamic> json) {
    return ResponseDataClass(
      Message: json['Message'] as String,
      IsSuccess: json['IsSuccess'] as bool,
      Data: json['Data'] as String,
    );
  }
}
