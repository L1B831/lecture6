// 布局实验台：用生活里的摆法演示对齐与弹性分配。
import 'package:flutter/material.dart'; // Material 组件库：Row、ListView、Switch 等

/// 布局实验台页面。
class LayoutLabPage extends StatefulWidget {
  const LayoutLabPage({super.key}); // 有状态：披萨分份的开关需要切换

  @override
  State<LayoutLabPage> createState() => _LayoutLabPageState(); // 创建状态对象
}

class _LayoutLabPageState extends State<LayoutLabPage> {
  /// 打开后妹妹换成固定宽的一整条，观察桌子放不下。
  bool _takeWholeStrip = false; // 默认关闭，保证页面初始摆得下

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('布局实验台')), // 顶部标题
      body: ListView(
        padding: const EdgeInsets.all(16), // 页面四周留白 16
        children: [
          // ---------- 第一节：同一批东西的六种摆法 ----------
          _LabSection(
            title: '一、早餐桌、全家福和书架',
            subtitle: '同样的东西，换个摆法就是另一种场景',
            children: [
              // 早餐桌上的三杯饮品全部靠左挤在一起
              _AlignDemo(
                title: '早餐桌：三杯饮品靠左排开',
                param: 'mainAxisAlignment: start',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // 主轴起点对齐，三杯紧挨着
                  children: const [
                    _LifeItem(icon: Icons.coffee, label: '咖啡', color: Color(0xFF8B5E3C)), // 第一杯
                    _LifeItem(icon: Icons.local_drink, label: '果汁', color: Color(0xFFF5A623)), // 第二杯
                    _LifeItem(icon: Icons.icecream, label: '冰淇淋', color: Color(0xFFE86A92)), // 第三杯
                  ],
                ),
              ),
              // 全家福：三个人站在画面正中
              _AlignDemo(
                title: '全家福：三口人站中间',
                param: 'mainAxisAlignment: center',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
                  children: const [
                    _LifeItem(icon: Icons.man, label: '爸爸', color: Color(0xFF4C6FFF)), // 爸爸
                    _LifeItem(icon: Icons.woman, label: '妈妈', color: Color(0xFFE86A92)), // 妈妈
                    _LifeItem(icon: Icons.child_care, label: '孩子', color: Color(0xFF2ECC71)), // 孩子
                  ],
                ),
              ),
              // 长餐桌：夫妻坐两头，中间空出来摆花瓶
              _AlignDemo(
                title: '长餐桌：夫妻坐两头，中间摆花瓶',
                param: 'mainAxisAlignment: spaceBetween',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 首尾贴边，中间等分
                  children: const [
                    _LifeItem(icon: Icons.man, label: '丈夫', color: Color(0xFF4C6FFF)), // 坐在左端
                    _LifeItem(icon: Icons.local_florist, label: '花瓶', color: Color(0xFF8A5CFF)), // 中间装饰
                    _LifeItem(icon: Icons.woman, label: '妻子', color: Color(0xFFE86A92)), // 坐在右端
                  ],
                ),
              ),
              // 晾衣绳：每件衣服两侧的空隙一样宽
              _AlignDemo(
                title: '晾衣绳：三件衣服，每件两侧留空相等',
                param: 'mainAxisAlignment: spaceAround',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // 每件两侧留白相等
                  children: const [
                    _LifeItem(icon: Icons.checkroom, label: '外套', color: Color(0xFF4C6FFF)), // 外套
                    _LifeItem(icon: Icons.checkroom, label: '衬衫', color: Color(0xFF2ECC71)), // 衬衫
                    _LifeItem(icon: Icons.checkroom, label: '围巾', color: Color(0xFFF5A623)), // 围巾
                  ],
                ),
              ),
              // 停车场：三辆车之间和两端的空隙完全相等
              _AlignDemo(
                title: '停车场：三辆车，车位间距一样',
                param: 'mainAxisAlignment: spaceEvenly',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 所有间距完全相等
                  children: const [
                    _LifeItem(icon: Icons.directions_car, label: '白车', color: Color(0xFF4C6FFF)), // 第一辆
                    _LifeItem(icon: Icons.directions_car, label: '绿车', color: Color(0xFF2ECC71)), // 第二辆
                    _LifeItem(icon: Icons.directions_car, label: '橙车', color: Color(0xFFF5A623)), // 第三辆
                  ],
                ),
              ),
              // 书架：三本书高低不同，书脊沿中线对齐
              _AlignDemo(
                title: '书架：词典、漫画、杂志高低不同，书脊对齐中线',
                param: 'crossAxisAlignment: center',
                height: 100, // 演示区加高，放得下最高的杂志
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // 交叉轴（垂直方向）居中
                  children: const [
                    _LifeItem(icon: Icons.menu_book, label: '词典', color: Color(0xFF4C6FFF), height: 44), // 最矮
                    _LifeItem(icon: Icons.menu_book, label: '漫画', color: Color(0xFF2ECC71), height: 62), // 中等
                    _LifeItem(icon: Icons.menu_book, label: '杂志', color: Color(0xFFF5A623), height: 80), // 最高
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // 两节之间的间距

          // ---------- 第二节：一张披萨按 2:1:1 分 ----------
          _LabSection(
            title: '二、一张长条披萨分给三个人',
            subtitle: '桌子就 360 宽，大哥出两份钱吃两份',
            children: [
              // 桌面宽度固定 360：浏览器再宽，桌子也只有这么长
              Center(
                child: SizedBox(
                  width: 360, // 桌面长度
                  child: Row(
                    children: [
                      // 大哥那份：flex 为 2，占 2 份宽度
                      const Expanded(flex: 2, child: _FlexBar(label: '大哥 · 2 份', color: Color(0xFF4C6FFF))),
                      const SizedBox(width: 8), // 份与份之间的刀口
                      // 二哥那份：flex 为 1，占 1 份宽度
                      const Expanded(flex: 1, child: _FlexBar(label: '二哥 · 1 份', color: Color(0xFF2ECC71))),
                      const SizedBox(width: 8), // 份与份之间的刀口
                      // 妹妹那份：随开关切换成固定宽，模拟自带一整条
                      if (_takeWholeStrip)
                        const SizedBox(
                          width: 400, // 固定 400 宽，超过 360 的桌面
                          child: _FlexBar(label: '妹妹 · 自带整条', color: Color(0xFFF5A623)),
                        )
                      else
                        // 正常状态：按 1 份参与分配
                        const Expanded(flex: 1, child: _FlexBar(label: '妹妹 · 1 份', color: Color(0xFFF5A623))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4), // 与开关行的间距
              Row(
                children: [
                  // 开关说明：妹妹不按份分，自己带一整条
                  const Expanded(
                    child: Text(
                      '妹妹不按份分，自己带一整条过来',
                      style: TextStyle(fontSize: 12, color: Colors.black54), // 小字说明
                    ),
                  ),
                  // 开关：切换妹妹那份的宽度来源
                  Switch(
                    value: _takeWholeStrip, // 当前状态
                    onChanged: (value) => setState(() => _takeWholeStrip = value), // 切换后重建
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 生活场景卡片：圆角、阴影、留白。
class _LabSection extends StatelessWidget {
  const _LabSection({required this.title, required this.subtitle, required this.children}); // 标题、一句话说明、内容

  final String title; // 小节标题
  final String subtitle; // 小节的一句话说明
  final List<Widget> children; // 小节内容

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // 卡片内留白 16
      decoration: BoxDecoration(
        color: Colors.white, // 白色卡片
        borderRadius: BorderRadius.circular(16), // 圆角 16
        boxShadow: const [
          // 与名片页一致的轻投影
          BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 内容左对齐
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), // 小节标题
          const SizedBox(height: 4), // 标题与说明的间距
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black45)), // 一句话说明
          const SizedBox(height: 12), // 说明与场景的间距
          ...children, // 展开传入的所有场景
        ],
      ),
    );
  }
}

/// 单个生活场景：场景标题、参数小字、演示区。
class _AlignDemo extends StatelessWidget {
  const _AlignDemo({
    required this.title,
    required this.param,
    required this.child,
    this.height = 72, // 默认演示区高度，能放下 44 高的物件
  });

  final String title; // 生活场景标题
  final String param; // 对应的布局参数
  final Widget child; // 演示用的 Row
  final double height; // 演示区高度

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // 场景之间的间距
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 标题与演示区左对齐
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.black87)), // 场景标题
          const SizedBox(height: 2), // 标题与参数的间距
          Text(param, style: const TextStyle(fontSize: 11, color: Colors.black38)), // 参数小字
          const SizedBox(height: 4), // 参数与演示区的间距
          Container(
            height: height, // 固定高度，便于比较摆法差异
            width: double.infinity, // 撑满卡片宽度
            padding: const EdgeInsets.symmetric(horizontal: 8), // 左右留 8，物件不贴边
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA), // 浅灰台面
              borderRadius: BorderRadius.circular(8), // 台面圆角 8
            ),
            child: child, // 真正演示摆法的 Row
          ),
        ],
      ),
    );
  }
}

/// 生活物件：圆角卡片里放一个图标和名字。
class _LifeItem extends StatelessWidget {
  const _LifeItem({
    required this.icon,
    required this.label,
    required this.color,
    this.height = 44, // 默认高度 44，书架上换成不同高度
  });

  final IconData icon; // 物件图标
  final String label; // 物件名字
  final Color color; // 物件主题色
  final double height; // 物件高度

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44, // 固定宽 44
      height: height, // 高度由参数决定
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14), // 主题色的浅色底
        borderRadius: BorderRadius.circular(8), // 圆角 8
        border: Border.all(color: color.withValues(alpha: 0.5)), // 1px 浅色描边
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 图标与名字在物件内居中
        children: [
          Icon(icon, size: 20, color: color), // 物件图标
          Text(label, style: TextStyle(fontSize: 9, color: color)), // 物件名字
        ],
      ),
    );
  }
}

/// 披萨的一份：带边框与文字的色块。
class _FlexBar extends StatelessWidget {
  const _FlexBar({required this.label, required this.color}); // 份的名字与颜色

  final String label; // 例如“大哥 · 2 份”
  final Color color; // 该份的主题色

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // 固定高度，突出宽度变化
      alignment: Alignment.center, // 文字居中
      padding: const EdgeInsets.symmetric(horizontal: 6), // 左右留 6，文字不贴边
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12), // 主题色的浅色填充
        borderRadius: BorderRadius.circular(8), // 圆角 8
        border: Border.all(color: color), // 1px 主题色描边
      ),
      child: Text(
        label, // 显示份的归属与份数
        textAlign: TextAlign.center, // 多行时居中
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color), // 主题色加粗小字
      ),
    );
  }
}
