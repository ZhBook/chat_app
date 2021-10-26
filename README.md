# chat_app

### 这是一款模仿微信APP的软件，通过Flutter实现。
### 目前仅有展示界面，后端计划通过JAVA编写。

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Notes
错误：LoadError - dlopen(/Library/Ruby/Gems/2.6.0/gems/ffi-1.13.1/lib/ffi_c.bundle, 0x0009): missing compatible arch...
执行下面操作
``
sudo arch -x86_64 gem install ffi
arch -x86_64 pod install
``

json文件生成
``
flutter packages pub run json_model
``

## IOS POD问题
在你的 ios 文件夹中，在终端中遵循这些命令

`sudo arch -x86_64 gem install ffi`

`arch -x86_64 pod install`
如果这仍然不能解决您的问题，请运行

`arch -x86_64 pod install --repo-update`

### M1更新软件ZLPhotoBrowser
arch -x86_64 pod update ZLPhotoBrowser
