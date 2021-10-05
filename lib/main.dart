import 'src/Dog.dart';
import 'src/Person.dart';

/**
 * https://github.com/dart-lang/samples/tree/master/command_line
 * https://github.com/DinoLeung/TeleDart
 * https://github.com/applebest/dart/tree/master/Dart_Demo
 * https://github.com/OMGyan/dart_study
 */

//类型推导
var name = "134";
//int是一个对象。在dart中，万物皆对象。
int age = 10;
Object c = 11;
//可变类型
dynamic d = 12;
//编译时常量
const e = '12345';
//运行时常量
final f = 13;
String g = '123456';

List list1 = [1, 2, 3];
var list2 = [1, '123', false, 4];
var list3 = List.empty();
//...是拓展操作符，list4.length = 4
var list4 = [1, ...list1];
var isIOS = false;
var list5 = ["windows", if (isIOS) 'ios' else 'android', "unix", 'linux'];
var list6 = ['unknown', for (var i in list5) i.toUpperCase()];

/**
 * dart中函数也是对象，它的类型是Function。它可以被赋值给变量或者作为其他函数的参数。
 */
int fibonacci(int n) {
  if (n == 0 || n == 1) {
    return 0;
  }
  return fibonacci(n - 1) + fibonacci(n - 2);
}

//对于只有一个表达式的函数，可以使用=>语法。和Kotlin很像。
getName() => "1234567";
//函数类型的变量。同Kotlin。也是dart中的匿名函数。
var function1 = (String str) {
  str.toUpperCase();
};
//Kotlin中的高阶函数。也是dart中的闭包。
Function function2(num number) {
  return (num i) => number + i;
}

//命名可选参数。需要指明参数名才可以调用
void function3({int seconds = 0, int minutes = 0, int hour = 0}) {
  print('$hour:$minutes:$seconds');
}

//位置可选参数。调用的时候也是按照顺序调用。
void function4([int date = 1, int month = 1, int year = 2021]) {
  print('$year-$month-$date');
}

//命名可选参数要放在参数列表的最后
void function5(var name, {int age = 20, int grade = 2}) {
  print('$name, $age, $grade');
}

//位置可选参数要放在参数列表的最后
void function6(String name, [String sex = 'male', String address = 'beijing']) {
  print('$name, $sex, $address');
}

//泛型
void function7<T extends Person>(T person) {
  person.greet();
}

/**
 * Dart是一种单线程的语言，故遇到有延迟的操作，都要异步处理，否则会造成堵塞。
 * Dart支持异步操作，语言提供了Future和Stream这两个异步操作类。
 * Future只能返回一次异步获取的数据。
 * Stream则可以返回多次异步获取的数据。
 *
 * 处理函数返回的Future对象
 * Future对象有两种状态:未完成/完成
 * await的意思是等待Future对象完成
 * 要使用await，必须在函数体前加上async
 *
 * Future是Dart内置的一个有自己队列策略的延迟计算对象
 */
Future function8() {
  //返回一个异步Future对象，5秒后才会完成。
  return Future.delayed(Duration(seconds: 5), () => '192.168.1.1');
}

/**
 * 这里的async并不是并行执行，它仅仅是一个语法糖，简化Future API的使用。
 */
void function9() async {
  print('开始获取IP');
  String ip = await function8();
  print('ip=$ip');
}

int function10(int a, int b) {
  return a + b;
}

//函数类型的变量
var h = (int a, int b) {
  return a + b;
};

//抽象类
abstract class A {
  String getName() {
    return 'A';
  }

  //抽象方法
  void aa();
}

class B extends A {
  /**
   * 必须实现抽象方法
   */
  @override
  void aa() {
    print('aa');
  }
}

void main() {
  print("Hello World!");
  var person = Person("qony");
  person.print1();
  d = "123";
  print(list6);
  print(getName());
  function1('abcd');
  print(function2(3)(4));
  function3();
  function3(hour: 2, seconds: 50);
  function4();
  function4(2);
  function5("pony", age: 50);
  function6("jack", "male", "hangzhou");
  function7(person);
  function9();
  print(function10(1, h(2, 3)));
  var dog = Dog();
  dog.play();
  dog.run();
}
