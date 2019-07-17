class User{
  String name;
  String desc;
  int age;

  User(this.name,this.desc,this.age);

  User.Empty():this(null,null,0);

  @override
  String toString() {
    return 'User{name: $name, desc: $desc, age: $age}';
  }


}

void main(){
  var user=User.Empty()
      ..name="Lin"
      ..desc="handsome"
      ..age=23;

  print(user);
}