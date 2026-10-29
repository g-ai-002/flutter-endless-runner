# 无尽跑酷 - Endless Runner 🏃

基于 Flutter + Flame 的无尽跑酷游戏，源码取自
[flutter/games](https://github.com/flutter/games/tree/main/templates/endless_runner) 官方
模板，只保留 Android、Windows 与 Web 三平台；依赖基线、Android 构建链与
GitHub / Gitea 双流水线均与
[flutter-snake](https://github.com/g-ai-002/flutter-snake) 保持一致。

## 功能

- 🏃 无尽跑酷核心玩法：点击 / 轻扫朝目标方向起跳，再点一次二段跳
- ✨ 收集 Ember 得分，躲避飞行敌人与地面障碍，达到目标分数即通关
- 🔓 关卡解锁与最高分进度持久化（shared_preferences）
- 🕹️ 主菜单、关卡选择（含翻页操作说明）与设置页
- ⚙️ 设置玩家名、音乐与音效开关（Web 端按浏览器策略默认静音起步）
- 🎨 NES 复古像素风主题（nes_ui + Press Start 2P 字体）
- 🌄 视差背景、跳跃 / 受击特效，合成音效与循环 BGM（flame_audio）
- 📱 自适应布局（手机 / 折叠屏 / 平板 / 桌面窗口）
- 🚀 GitHub Actions 与 Gitea Actions 双流水线：推送 `v*` 标签自动构建并发布
  Android APK、Windows ZIP 与 Web ZIP
- 🌐 GitHub Pages 多版本在线试玩：每个 `v*` 标签生成独立的 `v<版本>/` 目录

## 下载

### v0.1.0（当前版本）

- [Android APK](https://github.com/g-ai-002/flutter-endless-runner/releases/tag/v0.1.0)
- [Windows ZIP](https://github.com/g-ai-002/flutter-endless-runner/releases/tag/v0.1.0)
- [Web 在线试玩](https://g-ai-002.github.io/flutter-endless-runner/debug/)（首次需手动运行一次
  `Build & Release` 工作流；之后每个 `v*` tag 会生成独立的 `v<版本>/` 目录）

## 开发

### 环境要求

- Flutter 3.47.8+（内置 Dart 3.13.7+）
- Android SDK 37+（编译 SDK；最低支持 Android 15，仅覆盖最新 3 个 Android 大版本）
- Windows 10+

### 运行

```bash
flutter pub get
flutter run
```

### 测试

```bash
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
```

### Web

Web 平台由 CI 在构建时生成 `web/` 平台文件；本地预览前先执行：

```bash
flutter create --platforms=web --project-name flutter_endless_runner .
flutter run -d chrome
```

发布 `v*` tag 后，GitHub Pages 会为每个版本保留独立目录（`v0.1.0/` …），非 tag 构建
写入 `debug/`，根目录自动生成版本索引页与 `versions.json`。首次启用需在仓库
Settings → Pages 把来源设为 `gh-pages` 分支根目录。

### 发布

推送 `v*` 标签会触发 GitHub Actions 与 Gitea Actions 双流水线，分别构建 Android APK
与 Windows ZIP，并在对应平台自动创建 Release：

```bash
git tag v0.1.0
git push origin v0.1.0
```

构建产物的版本号取自 `pubspec.yaml` 的 `version` 字段，标签版本号优先。

## 技术栈

- Flutter 3.47.8
- Flame 1.38.2（游戏循环、碰撞与特效）
- flame_audio + audioplayers 6.8.1（音乐与音效）
- go_router 17.3.0（页面路由）
- provider 6.1.5+1（状态管理）
- nes_ui 0.30.0（NES 复古控件与主题）
- shared_preferences 2.5.6（设置与进度持久化）
- logging 1.3.0（分级日志）
- Web：GitHub Pages 多版本在线试玩

## 目录结构

```
lib
├── app_lifecycle    # 应用前后台状态
├── audio            # 音乐 / 音效控制
├── flame_game       # Flame 游戏主体（玩家、障碍、Ember、视差背景）
├── level_selection  # 关卡选择与操作说明
├── main_menu        # 主菜单
├── player_progress  # 关卡进度与最高分
├── settings         # 设置与持久化
├── style            # 调色板、响应式布局、NES 按钮
├── main.dart
└── router.dart
```

## 与上游模板的差异

- 仅保留 Android、Windows、Web：`ios/`、`linux/`、`macos/` 平台目录已移除；
  `web/`、`windows/` 由 CI 在构建时用 `flutter create` 生成（不入库）
- 依赖全部精确锁版本，Flutter / Flame / provider / shared_preferences / audioplayers
  与 flutter-snake 同一基线
- Android：包名 `com.flutter.endless_runner`、compileSdk 37.2 / targetSdk 37 /
  minSdk 35、统一长期签名、Gradle 9.8.2 + AGP 9.4.1 + Kotlin 2.4.21
- CI：GitHub / Gitea 两套工作流与 flutter-snake 完全同构（bash 优先、阿里云 Maven
  镜像、Windows 短路径构建、CMake CMP0091 兼容补丁、Pages 多版本站点）
- 界面文案沿用模板英文，可后续按需接入中文与 flutter_localizations

## 素材与许可

- 代码：[MIT](LICENSE)，第三方许可汇总见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)
- 音乐：CC0，出自 OpenGameArt，作者与链接见 `assets/music/CREDITS.TXT`
- 音效：CC0，见 `assets/sfx/README.md`
- 字体：Press Start 2P，SIL Open Font License，见 `assets/fonts/Press_Start_2P/OFL.txt`
- 游戏源码来自 Flutter 官方 [flutter/games](https://github.com/flutter/games) 模板
  （BSD-3-Clause）
