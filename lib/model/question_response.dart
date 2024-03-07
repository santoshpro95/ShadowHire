class QuestionResponse {
  List<Questions>? questions;

  QuestionResponse({this.questions});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? question;
  List<String>? options;

  Questions({this.question, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['options'] = this.options;
    return data;
  }
}
