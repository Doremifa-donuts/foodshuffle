import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // 選択された日付、時間、人数の初期値を設定
  DateTime selectedDate = DateTime.now(); // デフォルトの日付（今日）
  TimeOfDay selectedTime = const TimeOfDay(hour: 20, minute: 0); // デフォルトの時間
  int selectNum = 0; // 選択された人数
  final int limitNum = 10; // 最大予約可能人数
  final int bookingNum = 0; // 現在の予約数（ダミーデータ）

  @override
  Widget build(BuildContext context) {
    // 画面のテーマモードを取得（ライトモードかダークモードか）
    final isLightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text("予約画面"), // 画面タイトル
        backgroundColor:
            isLightMode ? Colors.white : Colors.black, // テーマに応じて色を変更
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 画面の余白
        child: Column(
          children: [
            const SizedBox(height: 16), // 上部余白
            ElevatedButton(
              // 日付を選択するボタン
              onPressed: () {
                DatePicker.showDatePicker(
                  context, // コンテキスト
                  minTime: DateTime.now(), // 今日以降しか選択できない
                  currentTime: selectedDate, // 現在の選択状態
                  locale: LocaleType.jp, // 日本ロケール
                  onConfirm: (date) {
                    setState(() {
                      selectedDate = date; // 選択された日付を更新
                    });
                  },
                );
              },
              child: Text(
                  "日付を選択: ${selectedDate.toString().substring(0, 10)}"), // 選択された日付を表示
            ),
            const SizedBox(height: 16), // 上部余白
            ElevatedButton(
              // 時間を選択するボタン
              onPressed: () {
                showTimePicker(
                  context: context, // コンテキスト
                  initialTime: selectedTime, // 現在の選択状態
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedTime = value; // 選択された時間を更新
                    });
                  }
                });
              },
              child:
                  Text("時間を選択: ${selectedTime.format(context)}"), // 選択された時間を表示
            ),
            const SizedBox(height: 16), // 上部余白
            Row(
              // 人数選択のボタンと表示
              mainAxisAlignment: MainAxisAlignment.center, // 中央に配置
              children: [
                IconButton(
                  icon: const Icon(Icons.remove), // マイナスアイコン
                  onPressed: selectNum > 0
                      ? () {
                          setState(() {
                            selectNum--; // 人数を減らす
                          });
                        }
                      : null, // 無効状態
                ),
                Text(
                  '$selectNum / ${(limitNum - bookingNum).clamp(0, limitNum)}', // 現在の人数と制限人数を表示
                  style: const TextStyle(fontSize: 24), // テキストスタイル
                ),
                IconButton(
                  icon: const Icon(Icons.add), // プラスアイコン
                  onPressed: selectNum < (limitNum - bookingNum)
                      ? () {
                          setState(() {
                            selectNum++; // 人数を増やす
                          });
                        }
                      : null, // 無効状態
                ),
              ],
            ),
            const SizedBox(height: 32), // 上部余白
            ElevatedButton(
              // 予約確定ボタン
              onPressed: selectNum > 0
                  ? () {
                      // 確認メッセージを表示
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("予約確認"), // ダイアログタイトル
                            content: Text(
                              "以下の内容で予約を送信しますか？\n\n日付: ${selectedDate.toString().substring(0, 10)}\n"
                              "時間: ${selectedTime.format(context)}\n"
                              "人数: $selectNum",
                            ), // 予約内容を表示
                            actions: [
                              TextButton(
                                child: const Text("キャンセル"), // キャンセルボタン
                                onPressed: () =>
                                    Navigator.pop(context), // ダイアログを閉じる
                              ),
                              TextButton(
                                child: const Text("送信"), // 送信ボタン
                                onPressed: () {
                                  Navigator.pop(context); // ダイアログを閉じる
                                  Navigator.pop(context); // ホーム画面に戻る
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("予約が送信されました")), // 成功メッセージを表示
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null, // 人数が選択されていない場合は無効化
              child: const Text("予約する"), // ボタンのテキスト
            ),
          ],
        ),
      ),
    );
  }
}
