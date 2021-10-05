import 'Animal.dart';
import 'Run.dart';
import 'Sleep.dart';

/**
 * mixin继承
 * 一种在多个类层次结构中重用类的代码的方法
 * 使用with关键字
 * 形式上类似多继承，但实际上是用单继承实现的，可以和单继承兼容。
 * 需要注意的是如果被mixin的类中有同名的函数，那么最后一个混入的函数会覆盖之前的函数。
 *
 * 这篇文章关于mixin的阐述非常好：https://km.woa.com/group/38862/articles/show/389234
 */
class Dog extends Animal with Run, Sleep {
  void play() {
    print('play');
  }
}
