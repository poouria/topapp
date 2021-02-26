class RegisterResponse {
  int Status;
  String Message;
  List<Register> Data;

  RegisterResponse({this.Status, this.Message, this.Data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    Status = json['Status'];
    Message = json['Message'];
    if (json['results'] != null) {
      Data = new List<Register>();
      json['results'].forEach((v) {
        Data.add(new Register.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.Status;
    data['Message'] = this.Message;
    if (this.Data != null) {
      data['Data'] = this.Data.map((v) => v.toJson()).toList();
    }else{
      this.Data = null;
    }
    return data;
  }
}

class Register {

  String RefMessage;
  String FlowToken;


  Register(
      {
        this.RefMessage,
        this.FlowToken,
       });

  Register.fromJson(Map<String, dynamic> json) {
    RefMessage = json['RefMessage'];
    FlowToken = json['FlowToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefMessage'] = this.RefMessage;
    data['FlowToken'] = this.FlowToken;
    return data;
  }
}