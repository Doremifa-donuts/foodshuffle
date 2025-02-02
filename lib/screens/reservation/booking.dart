import 'package:flutter/material.dart';
import 'package:foodshuffle/api/request_handler.dart';
import 'package:foodshuffle/api/urls.dart';
import 'package:foodshuffle/model/course/course.dart';
import 'package:foodshuffle/widgets/page_template.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用パッケージ

// ホームページ
import '../home_page.dart';

class ReservationPage extends StatefulWidget {
  final String restaurantUuid;
  const ReservationPage({super.key, required this.restaurantUuid});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

//

// 日付フォーマット
String getFormattedDate(DateTime? date) =>
    date != null ? DateFormat('yyyy/MM/dd').format(date) : '未選択';

String getFormattedTime(DateTime date) => DateFormat('HH:mm').format(date);

Future<List<Course>> fetchCourseList(String restaurantUuid) async {
  List<Course> courses = [];
  try {
    final data = await RequestHandler.jsonWithAuth(
        endpoint: Urls.courseList(restaurantUuid), method: HttpMethod.get);
    for (var item in data) {
      courses.add(Course.fromJson(item));
    }
    debugPrint(courses.toString());
  } catch (e) {
    debugPrint(e.toString());
  } finally {
    return courses;
  }
}

// 予約を送信する関数
Future<bool> _fetchReservation(
  String restaurantUuid,
  DateTime selectedDateTime,
  int numberOfPeople,
  String? courseUuid,
) async {
  // 日時、店舗、コース、人数を選択
  try {
    await RequestHandler.jsonWithAuth(
        endpoint: Urls.reservation(restaurantUuid),
        method: HttpMethod.post,
        body: {
          //TODO: 自国の表示の方法を修正する
          "ReservationDate":
              DateFormat("yyyy-MM-dd'T'HH:mm:ss+09:00").format(selectedDateTime),
          "CourseUuid": courseUuid,
          "CampaignUuid": null,
          "NumberOfPeople": numberOfPeople
        });
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

void bookingDialog(BuildContext context, DateTime? selectedDateTime,
    int? selectedPeople, String restaurantUuid, Course? selectedCourse) async {
  if (selectedDateTime == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('予約日時を選択してください。'),
      ),
    );
    return;
  }
  if (selectedPeople == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('人数を選択してください。'),
      ),
    );
    return;
  }

  // 確認ダイアログを表示
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('以下の内容で予約します'),
      content: Text(
          '日付: ${getFormattedDate(selectedDateTime)}\n時間: ${getFormattedTime(selectedDateTime)}\n人数:$selectedPeople人\n${selectedCourse != null ? 'コース:${selectedCourse.CourseName}\n価格:${selectedCourse.Price}円' : ''}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // ダイアログを閉じる
          },
          child: const Text('閉じる'),
        ),
        TextButton(
          onPressed: () async {
            bool result = await _fetchReservation(restaurantUuid,
                selectedDateTime, selectedPeople, selectedCourse?.CourseUuid);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('予約が完了しました'),
                ),
              );
              // ホームページに遷移
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('エラーが発生しました')),
              );
            }
          },
          child: const Text('予約を確定'),
        ),
      ],
    ),
  );
}

class _ReservationPageState extends State<ReservationPage> {
  List<Course>? courses;
  int minPeople = 1;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? selectedPeople;

  Course? selectedCourse;

  @override
  void initState() {
    super.initState();

    // コース一覧を取得する
    Future<void> fetchCourse() async {
      final fetchedCourses = await fetchCourseList(widget.restaurantUuid);
      setState(() {
        courses = fetchedCourses;
      });
    }

    // 非同期処理を呼び出す
    fetchCourse();
  }

  // 営業時間から選択可能な日付のリストを生成
  List<TimeOfDay> _generateTimeSlots() {
    final now = DateTime.now();
    List<TimeOfDay> timeSlots = [];
    DateTime startTime = DateTime(
      now.year,
      now.month,
      now.day,
      12, // 営業開始時間
      0,
    );
    DateTime endTime = startTime.copyWith(hour: 20, minute: 0); // 営業終了時間

    // 現在時刻が営業開始時間より後の場合、開始時間を現在時刻の次の30分に設定
    if (now.isAfter(startTime)) {
      startTime = now;
      // 30分単位に切り上げ
      if (startTime.minute > 0) {
        startTime = startTime.add(Duration(minutes: 30 - startTime.minute));
      }
    }

    while (startTime.isBefore(endTime) || startTime.isAtSameMomentAs(endTime)) {
      timeSlots.add(TimeOfDay(hour: startTime.hour, minute: startTime.minute));
      startTime = startTime.add(const Duration(minutes: 30));
    }

    return timeSlots;
  }

  // 営業時間の選択肢から今日の選択肢を除外
  List<TimeOfDay> _getAvailableTimeSlots() {
    final now = DateTime.now();
    final timeSlots = _generateTimeSlots();

    // 選択された日付が今日の場合のみ、現在時刻より前の時間を除外
    if (selectedDate?.year == now.year &&
        selectedDate?.month == now.month &&
        selectedDate?.day == now.day) {
      return timeSlots.where((timeSlot) {
        final slotDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          timeSlot.hour,
          timeSlot.minute,
        );
        return slotDateTime.isAfter(now);
      }).toList();
    }

    return timeSlots;
  }

  DateTime? get selectedDateTime {
    if (selectedDate == null || selectedTime == null) return null;
    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableTimeSlots = _getAvailableTimeSlots();
    // 現在の選択時間が利用可能な時間スロットに含まれていない場合、選択をリセット
    if (selectedTime != null && !availableTimeSlots.contains(selectedTime)) {
      selectedTime = null;
    }

    return PageTemplate(
      pageTitle: '予約ページ',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      initialDate: selectedDate ?? DateTime.now(),
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
            DropdownButtonFormField<TimeOfDay>(
              decoration: const InputDecoration(labelText: '時間を選択'),
              hint: const Text('未選択'),
              value: selectedTime,
              items: availableTimeSlots
                  .map((time) => DropdownMenuItem(
                        value: time,
                        child: Text(
                            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'),
                      ))
                  .toList(),
              onChanged: (TimeOfDay? time) {
                if (time != null) {
                  setState(() {
                    selectedTime = time;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: '人数を選択'),
              hint: const Text('未選択'),
              value: selectedPeople,
              items: List.generate(10, (index) => index + minPeople)
                  .map((people) => DropdownMenuItem(
                        value: people,
                        child: Text('$people 人'),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedPeople = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            courses != null
                ? courses!.isNotEmpty
                    ? DropdownButtonFormField(
                        decoration: const InputDecoration(labelText: 'コースを選択'),
                        hint: const Text('未選択'),
                        value: selectedCourse,
                        items: courses!
                            .map((course) => DropdownMenuItem<Course>(
                                value: course, child: Text(course.CourseName)))
                            .toList(),
                        onChanged: (value) => {
                          if (value != null)
                            {
                              setState(() {
                                selectedCourse = value;
                                minPeople = selectedCourse!.Minimum;
                                debugPrint('最小人数${minPeople}');
                                // 予約の人数が最低予約人数以下の場合人数を未選択に戻す
                                if (selectedPeople != null) {
                                  if (selectedPeople! < minPeople) {
                                    selectedPeople = null;
                                  }
                                }
                              })
                            }
                        },
                      )
                    : const SizedBox()
                : const SizedBox(),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: selectedDateTime != null
                    ? () {
                        bookingDialog(context, selectedDateTime, selectedPeople,
                            widget.restaurantUuid, selectedCourse);
                      }
                    : null,
                child: const Text('予約を確定する'),
              ),
            ),
            // if (selectedDateTime != null)
            //   Text(
            //     '選択日時: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime!)}',
            //     style: const TextStyle(fontSize: 18),
            //   )
            // else
            //   const Text(
            //     '日時が選択されていません',
            //     style: TextStyle(fontSize: 18),
            //   ),
          ],
        ),
      ),
    );
  }
}
