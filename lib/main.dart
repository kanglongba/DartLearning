import 'dart:io';

import 'package:DartLearning/src/School.dart';

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
//使用三个单引号或者三个双引号创建多行字符串
String j = '''第一行。
第二行。
第三行。
''';
//在字符串前加上 r 作为前缀创建 “raw” 字符串（即不会被做任何处理（比如转义）的字符串）
String i = r'在 raw 字符串中，转义字符串 \n 会直接输出 “\n” 而不是转义为换行。';
var k = null;
//表达式 1 ?? 表达式 2：如果表达式 1 为非 null 则返回其值，否则执行表达式 2 并返回其值
var l = k ?? i;

List list1 = [1, 2, 3];
var list2 = [1, '123', false, 4];
var list3 = List.empty();
//...是扩展操作符，list4.length = 4
var list4 = [1, ...list1];
//...?是 null-aware operator，表示非空才扩展。
var list9 = null;
var list7 = [1, ...?list9];
var isIOS = false;
var list5 = ["windows", if (isIOS) 'ios' else 'android', "unix", 'linux'];
var list6 = ['unknown', for (var i in list5) i.toUpperCase()];

var map1 = {
  "key1": "value1",
  "key2": 2,
  "key3": [1, 2, 3]
};

var set1 = {'pony', 'jack', 'charles'};

//指定类型
var set2 = <String>{'pony', 'jack', 'charles'};
var list8 = <int>[1, 2, 3];
var map2 = <String, int>{'key1': 1, 'key2': 2};

/**
 * dart中函数也是对象，它的类型是Function。它可以被赋值给变量或者作为其他函数的参数。
 * 所有的函数都有返回值，如果函数返回值定义为void，则接收到的返回值其实是null.
 * 如果省略了函数的返回值类型声明，那么函数返回一个 dynamic 类型的值。
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

T function27<T extends Person>(T person) {
  return person;
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
 * await/async可以理解为协程的支持
 * await要配合Future来使用
 * 会同步的获取等待Future的结果返回，才会继续往下走
 */
void function9() async {
  print('开始获取IP');
  String ip = await function8();
  print('ip=$ip');
}

//Stream
//异步生成器，生成的就是Stream
Stream<String> readFile() async* {
  // 该方法其实是用的异步生成器来生成的Stream对象
  for (int i = 1; i <= 3; i++) {
    sleep(Duration(seconds: 1));
    yield 'line ${i}'; // 使用yield向Stream中发射数据
  }
}

void runStream() {
  // 输出结果上，会每隔1秒打印一次
  readFile().listen((v) {
    print(v);
  });
}

//同步生成器，生成的是Iterable对象
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) {
    yield k++; //使用yield向Iterable中发射数据
  }
}

/**
 * 扩展函数。跟Kotlin就很像了。
 * since dart 2.7
 */
extension MyPersonExt on Person {
  study() {
    print('study');
  }
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

  //抽象方法，跟java中不同，抽象方法不用加abstract关键字
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

//if-else和switch-case跟java中的用法一样。
void function11(int num) {
  if (num.isEven) {
    print('奇数');
  } else if (num.isOdd) {
    print('偶数');
  } else {
    print('其他');
  }
  switch (num) {
    case 1:
      print('1');
      break;
    case 2:
      print('2');
      break;
    default:
      print('其他值');
      break;
  }
}

//循环控制条件业与Java一样。
void function12(int num) {
  for (int i = 0; i <= num; i++) {
    print(i);
  }
  int j = 0;
  while (j <= num) {
    print(j);
    j++;
  }
  int k = 0;
  do {
    print(k);
    k++;
  } while (k <= num);
}

//循环退出与Java一样。
void function13() {
  out:
  for (int i = 0; i <= 5; i++) {
    if (i == 4) {
      continue;
    }
    print("i=$i");
    if (i == 3) {
      for (int j = 0; j <= 4; j++) {
        print("j=$j");
        if (j == 4) {
          break out; //跳出到最外层：out。如果省略 out，只会跳出本层循环。
        }
      }
    }
  }
}

//遍历集合
void function14() {
  var list = [1, 3, 5, 7];
  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }
  for (int a in list) {
    print(a);
  }

  list.forEach((element) {
    print("e=$element");
  });
  var it = list.iterator;
  while (it.moveNext()) {
    print(it.current);
  }
  map1.forEach((key, value) {
    print('key=$key, value=$value');
  });
}

//fun是dynamic类型，也可以明确声明成Function类型
function15(fun) {
  print("function15");
  fun();
}

function16() {
  //这在Dart里面是一个函数，在Kotlin中是一个函数类型的变量。
  Function fun = () {
    print('function16');
  };
  function15(fun);
}

//非空操作
function17() {
  /**
   * 这里有四点与Kotlin一模一样：
   * ？声明可空变量
   * new关键字可以省略
   * 非空变量不可以赋值null（不过使用 dynamic/var 声明的变量可以赋值null）。
   * ! 表示确保不为null
   */
  Person? person = new Person("pony");
  person = null;
  //非空调用，与Kotlin一模一样
  person?.printName();
}

//类型判断
function18() {
  var pony = null;
  pony = Person('pony');
  if (pony is Person) {
    //这里不用强转类型了，编译器已经认定pony是Person对象，可以直接调用Person的方法。
    pony.printName();
  }
}

//类型强转
function19() {
  dynamic jack = Person.info('jack', 50);
  (jack as Person).printName();
}

//级联操作，效果类似Kotlin中的let/apply这类方法
function20() {
  var jack = Person('charles');
  jack
    ..printName()
    ..sayHello()
    ..greet()
    ..height789 = 226;
}

//这段代码有意思。
function21() {
  //声明列表
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    //列表的元素是一个函数。在Dart中函数也是一个对象，类型是Function。
    callbacks.add(() => print(i));
  }
  //遍历列表，并调用函数。最终输出 0 和 1.
  callbacks.forEach((c) => c());
  // callbacks.forEach((element) {
  //   element();
  // });
}

/**
 * 高阶函数：函数作为参数
 */
function22(int one, int two, int Function(int, int) func) {
  return func(one, two);
}

//dart可以将任何非null的对象作为异常拋出，而不局限于Exception或Error类型
function23(bool sw) {
  if (sw) {
    throw 'some exception';
  } else {
    throw FormatException('format exception');
  }
}
//异常处理
function24() {
  try {
    function23(false);
  } on FormatException {
    print('FormatException');
  } catch (e) {
    print(e);
    rethrow; // rethrow可以将接收到的异常重新拋出去
  }
}

//dart中函数内部还可以定义函数
function25() {
  function26() {
    print('function26');
  }

  print('function25');
  function26();
}

function28() {
  School school = School(Person('pony'));
  school.holiday(month: 7, day: 1);
}

void main() {
  print("Hello World!");
  var person = Person("qony");
  person.printName();
  person.height789 = 226;
  print(person.height123);
  Person.printCountry();
  //调用扩展函数
  person.study();
  d = "123";
  print(list6);
  print(map1["key1"]);
  map1['key4'] = 4;
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
  function11(5);
  function12(5);
  function13();
  function16();
  function17();
  function18();
  function19();
  function20();
  print(i);
  print(j);
  function21();
  print(function22(12, 23, function10));
  runStream();
  function25();
  function24();
  function28();
}
