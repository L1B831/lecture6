// 应用入口：初始化并启动 Flutter 应用。
import 'package:flutter/material.dart'; // Material 组件库：MaterialApp、ThemeData、Color 等

import 'pages/profile_card_page.dart'; // 本课作业的主页面：个人名片

/// 程序入口，Flutter 启动后第一个执行的函数。
void main() {
  runApp(const ProfileCardApp()); // runApp 把根组件挂载到屏幕上
}

/// 根组件：配置全局主题与首页。
class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key}); // 无状态组件用 const 构造，减少重建开销

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '个人名片', // 应用标题
      debugShowCheckedModeBanner: false, // 关闭右上角的 DEBUG 角标
      theme: ThemeData(
        useMaterial3: true, // 启用 Material 3 设计规范
        colorSchemeSeed: const Color(0xFF4C6FFF), // 用蓝色作种子，自动生成整套主色
        scaffoldBackgroundColor: const Color(0xFFF5F6FA), // 页面底色设为浅灰，衬托白卡片
      ),
      home: const ProfileCardPage(), // 首页指向名片页
    );
  }
}
