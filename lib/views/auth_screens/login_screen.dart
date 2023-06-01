import 'package:flutter/material.dart';
// import 'package:upcoming_movies/utils/shared/spacings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upcoming_movies/services/firebase_auth.dart';
import 'package:upcoming_movies/views/movies/movies_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? errorMessage ="";

  bool isLogin = true;


  String screenText = "Login";

  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth().signInWithEmailAndPassword(email: email.text, password: password.text);
    } on FirebaseAuthException catch(err){
    setState(() {
      errorMessage = err.message;
    });
    }
  }

  Future<void> signupWithEmailAndPassword() async{
    try{
      await Auth().signupWithEmailAndPassword(email: email.text, password: password.text);
    }on FirebaseAuthException catch(err){
      setState(() {
        errorMessage = err.message;
      });
    }
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // alignment: Alignment.center,
          padding:const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             const SizedBox(height: 50,),
             Container(
              alignment: Alignment.center,
              child: Text(screenText, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)),
        
             const SizedBox(height: 70,),
        
             const Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        
              TextFormField(
                controller: email,
                validator: (value) {
                  if(value ==""){
                    return "this field is required";
                  }
                },
              ),
        
             const SizedBox(height: 50,),
        
             const Text("Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        
              TextFormField(
                controller: password,
                obscureText: true,
                validator: (value) {
                  
                  if(value ==""){
                    return "this field is required";
                  }
                },
              ),

             const SizedBox(height: 50,),
              Container(
                alignment: Alignment.center,
                child: MaterialButton(
                  color: Colors.red,
                    onPressed: () {
                      isLogin? signInWithEmailAndPassword() : signupWithEmailAndPassword();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MoviesListScreen(),));
                    },
                    child: Container(
                      height: 60,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text("$screenText", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                    )
                ),
              ),

              SizedBox(height: 50,),
              Container(
                alignment: Alignment.center,
                child: TextButton(onPressed: (){
                  setState(() {

                    
                    isLogin = !isLogin;
                    if(isLogin){
                      screenText = "Login";
                    }else{
                    screenText = "SignUp";

                    }
                  });
                }, child: Text( isLogin? "don't have and account? Signup" : "Already hav an account? Login", style: TextStyle(fontSize: 18),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}