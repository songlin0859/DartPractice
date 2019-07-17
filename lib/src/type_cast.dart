class People{

}

class Student extends People{

}

void main(){
  var student=Student();
  var num=1;
  if(student is People){
    var people=student as People;
    print('people:${people.runtimeType.toString()}');
  }

  if(num is! People){
    print("num is not people");
  }
}