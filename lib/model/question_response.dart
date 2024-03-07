class QuestionResponse {
  List<Questions>? questions;
  String? phoneNo;
  String? emailId;

  QuestionResponse({this.questions, this.phoneNo, this.emailId});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
      phoneNo = json['phoneNo'];
      emailId = json['emailId'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['phoneNo'] = this.phoneNo;
    data['emailId'] = this.emailId;
    return data;
  }
}

class Questions {
  int? id;
  String? question;
  String? reason;
  String? answer;
  List<String>? options;

  Questions({this.id, this.question, this.reason, this.options, this.answer});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    reason = json['reason'];
    answer = json['answer'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['reason'] = this.reason;
    data['options'] = this.options;
    data['answer'] = this.answer;
    return data;
  }
}
