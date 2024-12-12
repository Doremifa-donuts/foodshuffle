import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodのインポート
import 'package:intl/intl.dart'; // 日付フォーマット用パッケージ
import '../../model/color.dart';
import '../../model/data_list.dart';

// ホームページ
import '../home_page.dart';

class ReservationPage extends ConsumerStatefulWidget {
  // ConsumerStatefulWidgetに変更
  final ArchiveStore store; // 受け取るstore

  const ReservationPage({Key? key, required this.store}) : super(key: key);

  @override
  ConsumerState<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends ConsumerState<ReservationPage> {
  // ConsumerStateに変更
  String selectedTime = '12:00';
  DateTime? selectedDate;
  int selectedPeople = 1;

  // 日付フォーマット
  String getFormattedDate(DateTime? date) {
    if (date == null) return '未選択';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '予約ページ',
          style: TextStyle(fontWeight: FontWeight.bold), // 太字のスタイル
        ),
        backgroundColor: const Color(mainColor),
      ), // アプリバーの背景色（共通定義）
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: '時間を選択'),
              value: selectedTime,
              items: ['12:00', '14:00', '16:00', '18:00', '20:00']
                  .map((time) => DropdownMenuItem(
                        value: time,
                        child: Text(time),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTime = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '日付: ${getFormattedDate(selectedDate)}',
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: const Text('日付を選択'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: '人数を選択'),
              value: selectedPeople,
              items: List.generate(10, (index) => index + 1)
                  .map((people) => DropdownMenuItem(
                        value: people,
                        child: Text('$people 人'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPeople = value!;
                });
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('日付を選択してください。'),
                      ),
                    );
                    return;
                  }

                  // 確認ダイアログを表示
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('予約完了'),
                      content: Text(
                          '予約が完了しました。\n店舗: ${widget.store.RestaurantName}\n時間: $selectedTime\n日付: ${getFormattedDate(selectedDate)}\n人数: $selectedPeople'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // ダイアログを閉じる
                          },
                          child: const Text('閉じる'),
                        ),
                        TextButton(
                          onPressed: () {
                            // 選択された情報を予約プロバイダに保存
                            ref.read(reservationProvider.notifier).state = {
                              'store': widget.store.RestaurantName,
                              'time': selectedTime,
                              'date': getFormattedDate(selectedDate),
                              'people': selectedPeople.toString(),
                            };

                            // ホームページに遷移
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text('予約を確定'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('予約を確定する'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
