part of 'widgets.dart';

showValidationBar(BuildContext context, {String message, Color color, IconData icon}) {
  return Flushbar(
    duration: Duration(milliseconds: 3000),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color,
    margin: EdgeInsets.all(10),
    borderRadius: 4,
    padding: EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 10,
    ),
    messageText: Text(
      message,
      style: regularBaseFont.copyWith(
        fontSize: 12.5,
      ),
    ),
    icon: Icon(
      icon,
      color: whiteColor,
    ),
  ).show(context);
}