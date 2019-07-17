/// Dart 是单继承的
/// Dart 没有 interface 关键字。在 Dart 中所有的类都隐含的定义了一个接口。
/// 因此你可以使用 implement 来实现任意的类隐含定义的接口。
class Spacecraft {
  String name;
  DateTime launchDate;
  int launchYear;

  /*Spacecraft(String name,DateTime launchDate){
    this.name=name;
    this.launchDate=launchDate;
    this.launchYear=this.launchDate?.year;
  }*/

  Spacecraft(this.name, this.launchDate) {
    this.launchYear = this.launchDate?.year;
  }

  Spacecraft.unlaunched(String name):this(name,null);

  void describe() {
    print('Spacecraft: $name');
    if (launchDate != null) {
      int years = new DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

class Manned {
  int astronauts;
  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}
//Mixins
class Orbiter extends Spacecraft with Manned {
  Orbiter(String name, DateTime launchDate) : super(name, launchDate);
  @override
  void describe() {
    super.describe();
    describeCrew();
  }
}
//抽象类
abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}
