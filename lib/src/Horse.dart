import 'Run.dart';

/**
 * 事实上，dart中每个类都可以认为是一个接口，借助关键字implements，我们可以将一个类作为接口使用。
 * 例如下面代码，如果用implements，那么B中就必须要重新实现A中除构造函数之外的所有成员函数。
 */
class Horse implements Run {
  @override
  void run() {
    print('horse run');
  }
}
