// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart'; // 测试框架：testWidgets、expect、finder

import 'package:profile_card/main.dart'; // 被测应用：根组件 ProfileCardApp

void main() {
  // 冒烟测试：确认应用能正常构建，并渲染出名片页的关键文字。
  testWidgets('Profile card smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileCardApp()); // 构建整个应用并完成首帧

    expect(find.text('张欣怡'), findsOneWidget); // 姓名已渲染
    expect(find.text('关注'), findsOneWidget); // 统计条第一个标签已渲染
    expect(find.text('关注 TA'), findsOneWidget); // 主按钮已渲染
  });
}
