import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'Student.dart';


class Welcome_Student extends StatefulWidget {
  const Welcome_Student({ Key? key }) : super(key: key);

  @override
  _Welcome_StudentState createState() => _Welcome_StudentState();
}

class _Welcome_StudentState extends State<Welcome_Student> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFC3A6),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 50),
            FadeInRight(
              duration: const Duration(milliseconds: 1500),
              child: Image.network('https://media3.giphy.com/media/FohU7pcZlaNQce7RJB/giphy.gif?cid=6c09b952zxriqfee02elq73ajcjs19xtst2t1xncwu6hkubb&ep=v1_stickers_related&rid=giphy.gif&ct=ts'
                ,fit: BoxFit.cover,),
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 500),
              child: Container(
                  padding: const EdgeInsets.only(left: 50, top: 40, right: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffFFC3A6).withOpacity(0.5),
                        offset: const Offset(0, -5),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 1000),
                          from: 50,
                          child: const Text(
                            'Discover the \n Upcoming Events.🔥',
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 1000),
                          from: 60,
                          child: Text(
                            ' Explore and Register⛰',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          delay: const Duration(milliseconds: 1000),
                          from: 70,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                // reload the page
                                Navigator.of(context).pushReplacementNamed('/');
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Student()));
                                },

                                child: const Text(
                                  'EXPLORE NOW ☕️',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}