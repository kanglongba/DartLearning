/**
 * Dart是一个面向对象的语言，支持单继承和mixin继承。定义类的关键字是class。
 * 如果定义类的时候没有提供构造方法，系统会自动生成一个无参数的构造方法。
 * 如果提供了有参数的构造方法，无参构造方法会失效，除非我们自己定义了无参构造。
 * 类由构造函数、实例变量和实例方法、类变量和类方法构成。没有析构函数。
 * 枚举类型是一种特殊的类。
 */
class Person {
  var name;
  int age = 20;

  /**
   * 主构造函数。
   * 一个类中只能有一个主构造函数。
   */
  Person(this.name);

  /**
   * 命名构造函数。
   * 一个类中可以有多个命名构造函数。
   */
  Person.info(String name, int age) {
    this.name = name;
    this.age = age;
  }

  String greet() => 'I am $name';

  /**
   * 函数的返回类型，可以省略。类似Kotlin。
   */
  sayHello() => "hello";

  print1() {
    print('the name is $name');
  }
}
