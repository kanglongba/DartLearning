import 'dart:async';

import 'dart:io';

void myTask() {
  print('this is my task');
}

/**
 * 将任务添加到MicroTask队列有两种方法
 */
function1() {
  // 1. 使用 scheduleMicrotask 方法添加
  scheduleMicrotask(myTask);

  // 2. 使用Future对象添加
  new Future.microtask(myTask);
}

/**
 * 将任务添加到Event队列
 */
function2() {
  new Future(myTask);
}

/**
 * Dart是单线程模型，采用事件循环的方式驱动。
 * microtask任务在event之前执行
 *
 * 结果：代码的运行顺序并不是按照我们的编写顺序来的，将任务添加到队列并不等于立刻执行，它们是异步执行的，当前main方法中的代码执行完之后，才会
 * 去执行队列中的任务，且MicroTask队列运行在Event队列之前。
 *
 * Future实现的异步，并没有运行在新线程上，它们始终运行在同一个线程上。只是通过事件循环的方式，避免了阻塞，达到了异步的效果。这种异步有点
 * 像Kotlin中的协程，只是一个任务调度框架，通过调度任务，让每个任务都得到执行的机会，从而避免后面的任务一直等待。它只适合IO等不消耗CPU的场景。
 */
function3() {
  print("main start");

  new Future(() {
    print("this is my event");
  });

  new Future.microtask(() {
    print("this is microtask");
  });

  print("main stop");
}

/**
 * 从结果可以看出，delayed方法调用在前面，但是它显然并未直接将任务加入Event队列，而是需要等待1秒之后才会去将任务加入，但在这1秒之间，后面
 * 的new Future代码直接将一个耗时任务加入到了Event队列，这就直接导致写在前面的delayed任务在1秒后只能被加入到耗时任务之后，只有当前面耗时
 * 任务完成后，它才有机会得到执行。这种机制使得延迟任务变得不太可靠，你无法确定延迟任务到底在延迟多久之后被执行。
 */
function4() {
  print("main start");

  // 1秒之后，再将任务添加到Event队列
  new Future.delayed(Duration(seconds: 1), () {
    print('task delayed 1 seconds');
  });

  new Future(() {
    // 模拟耗时5秒
    sleep(Duration(seconds: 5));
    print("5s task");
  });

  print("main stop");
}

/**
 * Future类是对未来结果的一个代理，它返回的并不是被调用的任务的返回值，只是封装了该任务的执行状态。
 */
function5() {
  Future fut = Future(myTask);
}

/**
 * 当Future中的任务完成后，我们往往需要一个回调，这个回调立即执行，不会被添加到事件队列
 */
function6() {
  print("main start");

  Future fut = new Future.value('18');
  // 使用then注册回调
  fut.then((res) {
    print(res);
  });

  // 链式调用，可以跟多个then，注册多个回调.
  new Future(() {
    print("async task");
  }).then((res) {
    print("async task complete");
  }).then((res) {
    print("async task after");
  }).catchError((e) {
    //使用catchError来处理异常
    print(e);
  }).whenComplete(() => print('complete'));

  print("main stop");
}

/**
 * 使用静态方法wait 等待多个任务全部完成后回调
 */
function7() {
  print("main start");

  Future task1 = new Future(() {
    print("task 1");
    return 1;
  });

  Future task2 = new Future(() {
    print("task 2");
    return 2;
  });

  Future task3 = new Future(() {
    print("task 3");
    return 3;
  });

  Future fut = Future.wait([task1, task2, task3]);
  fut.then((responses) {
    print(responses[0]);
    print(responses[1]);
    print(responses[2]);
    print(responses);
  });

  print("main stop");
}

// 模拟耗时操作，调用sleep函数睡眠2秒
doTask() {
  print('before sleep');
  sleep(Duration(seconds: 2));
  print('after sleep');
  return "Ok";
}

// 定义一个函数用于包装
schedule() async {
  var r = await doTask();
  print(r);
}

/**
 * async 不是并行执行，它是遵循Dart 事件循环规则来执行的，它仅仅是一个语法糖，简化Future API的使用
 *
 * 将 async 关键字作为方法声明的后缀时，具有如下意义
 * 1.该方法会同步执行其中的方法的代码直到第一个 await 关键字，然后它暂停该方法其他部分的执行；
 * 2.一旦由 await 关键字引用的 Future 任务执行完成，await的下一行代码将立即执行。
 */
function8() {
  print("main start");
  schedule();
  print("main end");
}

void main() {
  // function3();
  // function4();
  // function6();
  // function7();
  function8();
}
