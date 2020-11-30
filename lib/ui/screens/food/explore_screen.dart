part of 'package:comida/ui/screens/screens.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 "User Logged",
               ),
               SizedBox(
                 height: 10,
               ),
               RaisedButton(
                 child: Text(
                   "Logout",
                 ),
                 onPressed: () {},
               ),
             ],
           ),
        ),
      ),
    );
  }
}