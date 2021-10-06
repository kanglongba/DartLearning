import 'Person.dart';

/**
 * 泛型类
 */
class Generic<T extends Person> {
  T? person;

  Generic(this.person);

  sayHi() {
    person!.sayHello();
  }
}