// 个人名片页：在骨架上加容器装饰、状态徽标与常用组件。
import 'package:flutter/material.dart'; // Material 组件库：Container、BoxDecoration、TextField 等

/// 课堂作业六：个人名片页（单页）。
class ProfileCardPage extends StatefulWidget {
  const ProfileCardPage({super.key}); // 有状态组件：签名输入需要 controller 与刷新

  @override
  State<ProfileCardPage> createState() => _ProfileCardPageState(); // 创建对应的状态对象
}

class _ProfileCardPageState extends State<ProfileCardPage> {
  // 输入框控制器：读写 TextField 的内容，初始值就是默认签名。
  final TextEditingController _signatureController = TextEditingController(
    text: 'Flutter 学习者 · UI 设计爱好者',
  );

  @override
  void dispose() {
    _signatureController.dispose(); // 页面销毁时释放控制器，避免资源泄漏
    super.dispose(); // 保留父类销毁逻辑
  }

  // 读取输入框内容并给出提示，演示 controller 取值。
  void _saveSignature() {
    final String value = _signatureController.text.trim(); // 取文本并去掉首尾空格
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // 空内容与正常内容给不同提示
        content: Text(value.isEmpty ? '签名不能为空' : '已保存签名：$value'),
        duration: const Duration(seconds: 1), // 提示只停留 1 秒
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人名片')), // 顶部导航栏
      // 宽屏限宽 480 并水平居中，保持手机版式。
      body: Align(
        alignment: Alignment.topCenter, // 内容靠上
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480), // 最大宽度 480
          child: SingleChildScrollView(
            // 左右各 16，底部 24，滚动到底时卡片不贴边
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // 三张卡片横向撑满
              children: [
                _buildProfileCard(), // 名片主卡
                const SizedBox(height: 16), // 卡片间距 16
                _buildSignatureCard(), // 签名编辑卡
                const SizedBox(height: 16), // 卡片间距 16
                _buildProgressCard(), // 学习进度卡
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 名片主卡：头像、姓名签名、统计条、标签云、关注按钮。
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20), // 卡片内留白 20
      decoration: BoxDecoration(
        color: Colors.white, // 卡片底色；颜色必须写在 decoration 里
        borderRadius: BorderRadius.circular(16), // 圆角 16
        boxShadow: const [
          // 轻微投影：模糊 12，向下偏移 4
          BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 按钮等块级子项撑满宽度
        children: [
          const Center(child: _AvatarWithBadge()), // 头像与徽标居中放置
          const SizedBox(height: 12), // 头像与姓名之间的留白
          const Text(
            '张欣怡',
            textAlign: TextAlign.center, // 文字水平居中
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700), // 姓名字号与字重
          ),
          const SizedBox(height: 4), // 姓名与签名之间的小留白
          const Text(
            'Flutter 学习者 · UI 设计爱好者',
            textAlign: TextAlign.center, // 与姓名保持居中对齐
            style: TextStyle(fontSize: 13, color: Colors.black54), // 次要信息用灰色小字
          ),
          const SizedBox(height: 20), // 与统计条拉开层次
          _buildStatBar(), // 关注/粉丝/获赞统计
          const SizedBox(height: 20), // 统计条与标签云的间距
          _buildTagCloud(), // 兴趣标签
          const SizedBox(height: 24), // 标签与按钮的间距
          SizedBox(
            height: 44, // 固定按钮高度，视觉上更整齐
            child: ElevatedButton.icon(
              onPressed: () {}, // 静态页面，暂无业务逻辑
              icon: const Icon(Icons.add, size: 18), // 左侧加号图标
              label: const Text('关注 TA'), // 按钮文字
            ),
          ),
        ],
      ),
    );
  }

  /// 统计条：三个 Expanded 等分宽度。
  Widget _buildStatBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12), // 上下留白 12
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA), // 浅灰底色，与白色卡片区分
        borderRadius: BorderRadius.circular(12), // 圆角 12
      ),
      child: Row(
        children: const [
          Expanded(child: _StatItem(label: '关注', value: '128')), // 第 1 栏，占 1 份
          _StatDivider(), // 1px 分隔线
          Expanded(child: _StatItem(label: '粉丝', value: '2.4k')), // 第 2 栏
          _StatDivider(), // 1px 分隔线
          Expanded(child: _StatItem(label: '获赞', value: '9.8k')), // 第 3 栏
        ],
      ),
    );
  }

  /// 标签云：Wrap 自动换行。
  Widget _buildTagCloud() {
    return const Wrap(
      spacing: 8, // 同一行标签的水平间距
      runSpacing: 8, // 换行后行与行的垂直间距
      alignment: WrapAlignment.center, // 整行标签居中
      children: [
        _TagChip('Flutter'), // 标签 1
        _TagChip('Dart'), // 标签 2
        _TagChip('UI 设计'), // 标签 3
        _TagChip('摄影'), // 标签 4
        _TagChip('咖啡'), // 标签 5
      ],
    );
  }

  /// 签名编辑：TextField 取值 + 三种按钮。
  Widget _buildSignatureCard() {
    return Container(
      padding: const EdgeInsets.all(20), // 卡片内留白 20
      decoration: _cardDecoration(), // 与主卡一致的圆角与阴影
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 输入框撑满卡片宽度
        children: [
          const Text(
            '编辑签名',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // 小标题
          ),
          const SizedBox(height: 12), // 标题与输入框的间距
          TextField(
            controller: _signatureController, // 绑定控制器，便于读取内容
            maxLines: 2, // 最多两行，长签名可换行
            decoration: InputDecoration(
              hintText: '写一句介绍自己的话', // 未输入时的占位文字
              isDense: true, // 压缩内边距，避免输入框过高
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // 输入框圆角与卡片统一
              ),
            ),
          ),
          const SizedBox(height: 12), // 输入框与按钮行的间距
          Wrap(
            spacing: 8, // 按钮之间的水平间距
            runSpacing: 8, // 一行放不下时换行的间距
            children: [
              ElevatedButton(onPressed: _saveSignature, child: const Text('保存')), // 强调按钮
              OutlinedButton(
                onPressed: () => _signatureController.clear(), // 清空输入
                child: const Text('清空'), // 描边按钮
              ),
              TextButton(
                onPressed: () => _signatureController.text = 'Flutter 学习者', // 填回默认短签名
                child: const Text('恢复默认'), // 文字按钮
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 学习进度：线性与环形进度条。
  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20), // 卡片内留白 20
      decoration: _cardDecoration(), // 复用统一装饰
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 左右两块顶部对齐
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
              children: [
                const Text(
                  '本周学习进度',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), // 小标题
                ),
                const SizedBox(height: 10), // 标题与进度条的间距
                ClipRRect(
                  borderRadius: BorderRadius.circular(4), // 给进度条加圆角
                  child: const LinearProgressIndicator(
                    value: 0.62, // 62% 进度
                    minHeight: 8, // 线宽 8
                    backgroundColor: Color(0xFFE8EBF2), // 未完成部分底色
                  ),
                ),
                const SizedBox(height: 8), // 进度条与说明文字的间距
                const Text(
                  '已看完 3 / 5 个章节',
                  style: TextStyle(fontSize: 12, color: Colors.black54), // 说明文字
                ),
                const SizedBox(height: 4), // 与禁用按钮的间距
                TextButton(
                  onPressed: null, // 禁用态：按钮自动置灰
                  child: const Text('下周解锁'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), // 左右两块之间的间距
          const SizedBox(
            width: 48,
            height: 48, // 固定尺寸，让环形进度条有确定大小
            child: CircularProgressIndicator(value: 0.62, strokeWidth: 5), // 62% 圆环
          ),
        ],
      ),
    );
  }

  // 统一的卡片装饰：白底、圆角 16、轻投影。
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white, // 白色卡片
      borderRadius: BorderRadius.circular(16), // 圆角 16
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)), // 与主卡一致
      ],
    );
  }
}

/// 头像与右下角在线徽标。
/// Stack 尺寸由 CircleAvatar 决定，Positioned 徽标不参与。
class _AvatarWithBadge extends StatelessWidget {
  const _AvatarWithBadge(); // 无状态，直接 const 构造

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // 允许徽标压出头像边界
      children: [
        const CircleAvatar(
          radius: 44, // 半径 44，直径 88
          backgroundColor: Color(0xFFE8EDFF), // 浅蓝底
          child: Icon(Icons.person, size: 48, color: Color(0xFF4C6FFF)), // 默认头像图标
        ),
        Positioned(
          right: 2, // 距头像右边缘 2
          bottom: 2, // 距头像下边缘 2
          child: Container(
            width: 16, // 徽标直径 16
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71), // 绿色表示在线
              shape: BoxShape.circle, // 圆形
              border: Border.all(color: Colors.white, width: 2), // 2px 白边与头像分离
            ),
          ),
        ),
      ],
    );
  }
}

/// 统计条中的单个数字块：数字在上，标签在下。
class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value}); // 由父组件传入标签与数值

  final String label; // 例如“关注”
  final String value; // 例如“128”

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 高度贴合内容，不额外占空间
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // 数字加粗
        ),
        const SizedBox(height: 2), // 数字与标签之间的间距
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)), // 灰色小标签
      ],
    );
  }
}

/// 统计条中的 1px 分隔线：固定宽高，不参与弹性分配。
class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 28, color: Colors.black12); // 1px 宽、28 高的浅灰竖线
  }
}

/// 标签胶囊：浅蓝底 + 主色文字。
class _TagChip extends StatelessWidget {
  const _TagChip(this.text); // 只接收标签文字

  final String text; // 标签内容

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // 胶囊内边距
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1FF), // 浅蓝底
        borderRadius: BorderRadius.circular(999), // 足够大的圆角形成胶囊
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Color(0xFF4C6FFF)), // 主色小字
      ),
    );
  }
}
