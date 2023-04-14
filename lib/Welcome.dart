import 'package:flutter/material.dart';
import 'package:project/Teacher.dart';


class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ3OaUCJh5JO3WqtPFqrt6DOTlu6nboBApV6Uo5qWWjTIdpHQCW7A1HR8wAOHbhcnQPk4&usqp=CAU'),fit: BoxFit.cover

          )
      ),
      child: Scaffold(
    backgroundColor : Colors.transparent,
    body: SingleChildScrollView (
      child:  Column(
      children: [
      Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
        //  height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 35,top: 100),
          child: Text('About NSS' , style: TextStyle(color: Colors.black, fontSize: 33), )

      ),
        const SizedBox(
          height: 20,
        ),

        Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 30),
            child: Text('National Service Scheme (NSS) was introduced in 1969 with the primary objective of developing the personality and character of the student youth through voluntary community service. Education through Service is the purpose of the NSS. The ideological orientation of the NSS is inspired by the ideals of Mahatma Gandhi.' , style: TextStyle(color: Colors.black, fontSize: 15), )
        ),
        const SizedBox(
          height: 20,
        ),

        Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 30,top: 25),
            child: Text('National Service Scheme (NSS) was introduced in 1969 with the primary objective of developing the personality and character of the student youth through voluntary community service. Education through Service is the purpose of the NSS. The ideological orientation of the NSS is inspired by the ideals of Mahatma Gandhi.' , style: TextStyle(color: Colors.black, fontSize: 15), )
        ),

        const SizedBox(
          height: 50,
        ),

        ElevatedButton(onPressed: (){

          Navigator.pushNamed(context, '/teacher');

        }, child: const Text('Take a Look at the Events'))

          ],
        ),
    )

      )
    );
  }
}