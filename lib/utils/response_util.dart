/// Manage utility function for response repository api.

class ResponseUtil {
  Object data;
  List<Object> list;
  dynamic error;
  int statusCode;
  String message;

  ResponseUtil({
    this.data,
    this.list,
    this.error,
    this.statusCode = 200,
    this.message,
  });

  static ResponseUtil resultResponse({Object data, List<Object> list, dynamic error, int statusCode, String message}) {
    switch(statusCode) {
      case 500:
        return ResponseUtil(
          message: message,
          statusCode: 500,
          error: error,
        );
        break;
      case 400:
        return ResponseUtil(
          message: message,
          statusCode: 400,
          error: error,
        );
        break;
      case 422:
        return ResponseUtil(
          message: message,
          statusCode: 400,
          error: error,
        );
        break;
      case 450:
        return ResponseUtil(
          message: message,
          statusCode: 450,
          error: error,
        );
        break;
      default:
        return ResponseUtil(
          message: message,
          data: data,
          list: list,
        );
    }
  }
}