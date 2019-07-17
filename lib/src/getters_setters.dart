void main(){
  var user=User("Lin",28);
  print(user.trueAge);
}
///Getters 和 setters 是用来设置和访问对象属性的特殊 函数。
///每个实例变量都隐含的具有一个 getter， 如果变量不是 final 的则还有一个 setter。
///你可以通过实行 getter 和 setter 来创建新的属性，
///使用 get 和 set 关键字定义 getter 和 setter：
class User{
  String name;
  int age;

  User(this.name,this.age);

  //int get trueAge =>age+1;
  int get trueAge{
    return age+1;
  }
}