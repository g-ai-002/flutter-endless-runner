# 无尽跑酷 — 项目规划

## 长期目标

- 跨 Android + Windows + Web 三平台的无尽跑酷游戏
- 精美的复古像素风界面，操作与主流手游一致
- 关卡、收集与躲避玩法可持续扩展，每关目标分数可调
- 持续可演进：每个版本可独立交付，可观测、可回滚

## 中期目标

- [x] 无尽跑酷核心玩法：自动前进、点击/轻扫起跳、二段跳
- [x] 收集 Ember 计分，飞行敌人与地面障碍碰撞扣分
- [x] 关卡进度、解锁与最高分持久化
- [x] 主菜单 / 关卡选择 / 操作说明 / 设置多页面路由
- [x] 设置：玩家名、音乐与音效开关
- [x] 自适应布局（手机 / 折叠屏 / 平板 / 桌面窗口）
- [x] 视差背景、跳跃/受击特效、音效与循环 BGM
- [x] 双流水线构建与发布（GitHub Actions / Gitea Actions，push tag 自动发布
  Android + Windows + Web 交付件）
- [x] GitHub Pages 多版本在线试玩（每个 tag 一个独立版本目录）
- [x] 简体中文界面：接入 flutter_localizations，默认 zh_CN，文案全部汉化
- [ ] 落盘日志系统（按日写入用户目录，便于排障）
- [ ] 更多关卡主题、敌人类型与背景音乐

## 短期目标

- 先用 v0.1.0 打通三平台构建与发布链，再按 MINOR/PATCH 节奏迭代

---

## 版本历史

### v0.1.0 (MINOR)

- **状态**: 开发完成，待 CI 验证 ⏳
- **目标**: 从 flutter/games 官方 endless_runner 模板落地三平台版本
- **任务**:
  - [x] 复制模板源码（lib / assets / test / android）到本仓库
  - [x] 只保留 Android、Windows、Web 三平台，移除 ios / linux / macos
  - [x] 依赖按 flutter-snake 基线精确锁版本，包名改为 `flutter_endless_runner`
  - [x] Android 构建链对齐 snake：compileSdk 37.2 / targetSdk 37 / minSdk 35、
        NDK 30.0.16248370、Gradle 9.8.2 + AGP 9.4.1 + Kotlin 2.4.21、统一长期签名
  - [x] analysis_options / .gitignore 与 snake 保持一致
  - [x] 复刻 GitHub Actions 与 Gitea Actions 工作流（含 Pages 多版本站点与
        阿里云 Maven 镜像、Windows 短路径构建、CMake CMP0091 补丁）
  - [x] 模板测试改用新包名，本地 `flutter analyze` / `flutter test` 通过
  - [x] 接入 flutter_localizations，locale 固定 zh_CN，主菜单 / 关卡选择 / 玩法说明 /
        设置 / 结算文案全部汉化，默认玩家名改为“玩家”
  - [x] README / plan / versions 文档

---

## 设计原则

- **离线优先**：纯本地游戏，不联网；字体随包内置，不依赖运行时下载
- **中文优先**：界面默认简体中文，新增文案同样使用中文
- **克制设计**：NES 复古像素风，扁平化，少即是多
- **包体克制**：依赖均为成熟稳定的纯 Dart / Flutter 插件，避免引入大型原生 SDK
- **双流水线等价**：GitHub 与 Gitea 构建产物一致，Windows 步骤优先 bash

## 依赖与版本基线

- Flutter: 3.47.8
- flutter_localizations: Flutter SDK 内置（intl 0.20.3），默认 locale `zh_CN`
- Dart: 3.13.7（对应 Flutter 3.47.8 内置 Dart SDK）
- Android SDK: compileSdk=37.2 / targetSdk=37 / minSdk=35，NDK 30.0.16248370
- flame: 1.38.2
- flame_audio: 2.12.2
- go_router: 17.3.0
- provider: 6.1.5+1
- shared_preferences: 2.5.6
- nes_ui: 0.30.0
- google_fonts: 6.3.3（字体由 nes_ui 内置资源提供，离线可用）
- logging: 1.3.0
- audioplayers: 6.8.1
