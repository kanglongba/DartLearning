import 'Person.dart';

class Boy extends Person {
  String school = 'zju';

  /**
   * 如果父类没有无参数构造函数，子类必须显示调用父类构造函数。
   * 构造函数执行顺序: 默认值->初始化列表->父类的构造函数->当前类的构造函数。
   */
  Boy(name, String school) : super(name) {
    age = 19;
    this.school = school;
  }

  /**
   * 重写父类方法
   */
  @override
  String sayHello() {
    return "welcome";
  }
}
