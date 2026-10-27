// 个人名片页：先搭骨架，只处理结构与对齐。
import 'package:flutter/material.dart'; // Material 组件库：Scaffold、Text、Row、Wrap 等

/// 课堂作业六：个人名片页。
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key}); // 骨架阶段无交互，用无状态组件

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人名片')), // 顶部标题
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16), // 页面四周留白 16
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // 子项横向撑满
          children: [
            // 头像、姓名、签名：三者居中排成一列
            const Column(
              children: [
                CircleAvatar(radius: 44, child: Icon(Icons.person, size: 48)), // 头像
                SizedBox(height: 12), // 头像与姓名的间距
                Text(
                  '张欣怡',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // 姓名
                ),
                SizedBox(height: 4), // 姓名与签名的间距
                Text(
                  'Flutter 学习者 · UI 设计爱好者',
                  style: TextStyle(fontSize: 13, color: Colors.black54), // 签名
                ),
              ],
            ),
            const SizedBox(height: 20), // 与统计条的间距
            // 统计条：三个 Expanded 等分宽度
            Row(
              children: const [
                Expanded(child: _StatItem(label: '关注', value: '128')), // 第 1 栏
                Expanded(child: _StatItem(label: '粉丝', value: '2.4k')), // 第 2 栏
                Expanded(child: _StatItem(label: '获赞', value: '9.8k')), // 第 3 栏
              ],
            ),
            const SizedBox(height: 20), // 与标签云的间距
            // 标签云：Wrap 放不下就换行
            const Wrap(
              spacing: 8, // 水平间距
              runSpacing: 8, // 行间距
              alignment: WrapAlignment.center, // 整行居中
              children: [
                _TagChip('Flutter'), // 标签 1
                _TagChip('Dart'), // 标签 2
                _TagChip('UI 设计'), // 标签 3
                _TagChip('摄影'), // 标签 4
                _TagChip('咖啡'), // 标签 5
              ],
            ),
            const SizedBox(height: 24), // 与按钮的间距
            SizedBox(
              height: 44, // 固定按钮高度
              child: ElevatedButton(
                onPressed: () {}, // 静态页面，暂无业务逻辑
                child: const Text('关注 TA'), // 按钮文字
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 统计条里的单个数字块：数字在上，标签在下。
class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value}); // 由父组件传入标签与数值

  final String label; // 例如“关注”
  final String value; // 例如“128”

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 高度贴合内容
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // 数字加粗
        ),
        const SizedBox(height: 2), // 数字与标签的间距
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)), // 灰色小标签
      ],
    );
  }
}

/// 标签：骨架阶段只放文字。
class _TagChip extends StatelessWidget {
  const _TagChip(this.text); // 只接收标签文字

  final String text; // 标签内容

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 13)); // 纯文字标签
  }
}
