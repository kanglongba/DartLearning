import 'Run.dart';

/**
 * Dart 没有 interface 关键字。相反，所有的类都隐式定义了一个接口。因此，任意类都可以作为接口被实现。
 * 例如下面代码，如果用implements，那么B中就必须要重新实现A中除构造函数之外的所有成员函数。
 */
class Horse implements Run {
  @override
  void run() {
    print('horse run');
  }
}
