class Myexception implements Exception {
  String? heading;
  String? msg;

  Myexception({this.heading, this.msg});
  @override
  String toString() {
    return '$heading:$msg';
  }
}

class UnAuthorisedException extends Myexception {
  UnAuthorisedException(String msg)
      : super(heading: "UnAuthrosied Exception", msg: msg);
}

class FetchDataException extends Myexception {
  FetchDataException(String msg) : super(heading: "Fetch Exception", msg: msg);
}

class BadRequestException extends Myexception {
  BadRequestException(String msg)
      : super(heading: "BadRequest Exception", msg: msg);
}

class InvalidInputException extends Myexception {
  InvalidInputException(String msg)
      : super(heading: "InvalidInput Exception", msg: msg);
}

// class UnAuthorisedException extends Myexception{
//   UnAuthorisedException(String msg):super(heading:"UnAuthrosied Exception",msg:msg);
// }