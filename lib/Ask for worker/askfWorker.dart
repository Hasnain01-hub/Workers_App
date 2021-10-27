import 'package:flutter/material.dart';
import 'package:workers_app/Ask%20for%20worker/Registerform.dart';
import 'package:workers_app/home.dart';
class Askfworker extends StatefulWidget {
  const Askfworker({Key? key}) : super(key: key);

  @override
  _AskfworkerState createState() => _AskfworkerState();
}

class _AskfworkerState extends State<Askfworker> {
  @override
  bool pre=false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFfef0d8),
        child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                "asset/workers.gif",fit: BoxFit.cover,
              ),
            ),

            Text("Are you a Worker?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 30.0),),
        InkWell(
          onTap: ()async{
            setState(() {
              pre = true;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Registerform()));
            });
            await Future.delayed( Duration(seconds: 1));
          },
          child: AnimatedContainer(

            height: 47,

            duration: Duration(seconds: 1),
            width:pre?47: 250,
            alignment: Alignment.center,
            child:pre?Icon(Icons.check,color: Colors.white,):
            Text("Register as a worker"
              ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.0),),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(pre?40:10)
            ),

          ),
        ),
SizedBox(height: 10.0,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(

                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => homePage()));
                }, child: Text("Skip",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.0),

            ),
              style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                  )
              )),
            clipBehavior: Clip.antiAlias,
            )
          ],
        ),
      )
          ],
        ),
      ),
    );
  }
}

//#fef0d8