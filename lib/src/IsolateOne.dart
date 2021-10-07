import 'dart:io';
import 'dart:isolate';

createMainIsolate() async {
  ReceivePort mainReceive = ReceivePort();
  SendPort mainSend = mainReceive.sendPort;
  SendPort? newSend;

  Isolate newIsolate = await Isolate.spawnUri(Uri(path: "./IsolateTwo.dart"),
      ["hello, 新isolate", "我是 主isolate"], mainSend);

  mainReceive.listen((message) {
    if (message is SendPort) {
      newSend = message;
    } else {
      print('主isolate接收到消息：$message');
      newSend?.send("主isolate 已经接收到你的消息");
    }
  });

  // 可以在适当的时候，调用以下方法杀死创建的 isolate
  // newIsolate.kill(priority: Isolate.immediate);
}

/**
 * 使用spawnUri创建Isolate
 */
function1() {
  print("主isolate start");
  createMainIsolate();
  print("主isolate stop");
}

// 处理耗时任务
void doWork(SendPort mainSend) {
  print("新isolate start");
  ReceivePort newReceive = new ReceivePort();
  SendPort newSend = newReceive.sendPort;

  newReceive.listen((message) {
    print("新isolate 接收到消息: $message");
  });

  // 将新isolate中创建的SendPort发送到主isolate中用于通信
  mainSend.send(newSend);
  // 模拟耗时5秒
  sleep(Duration(seconds: 5));
  mainSend.send("新isolate 任务完成");

  print("新isolate end");
}

createMainIsolate2() async {
  ReceivePort mainReceive = ReceivePort();
  SendPort mainSend = mainReceive.sendPort;
  SendPort? newSend;
  Isolate? newIsolate;

  mainReceive.listen((message) {
    if (message is SendPort) {
      newSend = message;
    } else {
      newSend?.send('主isolate 已经收到你的消息：$message');
    }
  });

  newIsolate = await Isolate.spawn(doWork, mainSend);

  //newIsolate?.kill(priority: Isolate.immediate);
}

/**
 * 使用 spawn 创建isolate
 */
function2() {
  print("主isolate start");
  createMainIsolate2();
  print("主isolate end");
}

/**
 * Isolate，可以把它理解为Dart中的线程。但它又不同于线程，更恰当的说应该是微线程，或者说是协程。它与线程最大的区别就是不能共享内存，因此
 * 也不存在锁竞争问题，两个Isolate完全是两条独立的执行线，且每个Isolate都有自己的事件循环，它们之间只能通过发送消息通信，所以它的资源开
 * 销低于线程。
 *
 * 无论是spawn还是spawnUri，运行后都会创建两个进程，一个是主Isolate的进程，一个是新Isolate的进程，两个进程都双向绑定了消息通信的通道，即
 * 使新的Isolate中的任务完成了，它的进程也不会立刻退出，因此，当使用完自己创建的Isolate后，最好调用:
 * newIsolate.kill(priority: Isolate.immediate);
 * 将Isolate立即杀死。
 *
 * Isolate虽好，但也有合适的使用场景，不建议滥用Isolate，应尽可能多的使用Dart中的事件循环机制去处理异步任务，这样才能更好的发挥Dart语言
 * 的优势。那么应该在什么时候使用Future，什么时候使用Isolate呢？一个最简单的判断方法是根据某些任务的平均时间来选择：
 * 1.方法执行在几毫秒或十几毫秒左右的，应使用Future
 * 2.如果一个任务需要几百毫秒或之上的，则建议创建单独的Isolate
 * 3.除此之外，还有一些可以参考的场景(都是一些CPU密集型场景和等待时间不确定型场景):
 * JSON 解码
 * 加密
 * 图像处理：比如剪裁
 * 网络请求：加载资源、图片
 */
void main() {
  function2();
}
