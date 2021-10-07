import 'dart:io';
import 'dart:isolate';

/**
 * 需要注意，用于运行新Isolate的代码文件中，必须包含一个main函数，它是新Isolate的入口方法，该main函数中的args参数列表，正对应spawnUri中
 * 的第二个参数。如不需要向新Isolate中传参数，该参数可传空List
 */
void main(args, SendPort mainSend) {
  print("新isolate start");
  print("新isolate args: $args");

  ReceivePort newReceive = ReceivePort();
  SendPort newSend = newReceive.sendPort;

  newReceive.listen((message) {
    print("接收主isolate message: $message");
  });

  // 将当前 isolate 中创建的SendPort发送到主 isolate中用于通信
  mainSend.send(newSend);

  // 模拟耗时5秒
  sleep(Duration(seconds: 5));

  mainSend.send('新isolate 任务完成');

  print("新isolate stop");
}
