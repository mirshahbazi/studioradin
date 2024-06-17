# studioradin

### پروژه Flutter

این پروژه یک اپلیکیشن Flutter است که به عنوان یک پروژه آزمایشی برای پیشنهاد شغلی تهیه شده است. در این مستندات به توضیح ساختار و معماری پروژه پرداخته می‌شود.

### پیش‌نیازها

برای اجرای این پروژه نیاز به نصب موارد زیر دارید:
- Flutter SDK
- Dart SDK
- کتابخانه‌های مورد نیاز که در فایل `pubspec.yaml` ذکر شده‌اند.

### نصب و راه‌اندازی

1. ابتدا Flutter و Dart را نصب کنید.
2. کتابخانه‌های مورد نیاز را با اجرای دستور زیر نصب کنید:
   ```bash
   flutter pub get

## :cactus: Folder Structure

      .
      lib/
      ├── core/
      │   ├── app/
      │   │   ├── app_bindings.dart
      │   │   ├── app_controller.dart
      │   │   ├── app_repository.dart
      │   │   └── app_widget.dart
      │   ├── components/
      │   │   ├── index.dart
      │   │   └── src/
      │   │       ├── carousel_slider.dart
      │   │       ├── custom_container.dart
      │   │       ├── gradient_shadow_box_decoration.dart
      │   │       ├── image.dart
      │   │       ├── keyboard_service.dart
      │   │       ├── percent_indicator.dart
      │   │       ├── radar_chart.dart
      │   │       └── rating_bar.dart
      │   ├── constants/
      │   │   ├── images.dart
      │   │   ├── public_const.dart
      │   │   ├── string.dart
      │   │   └── theme/
      │   │       ├── styles.dart
      │   │       └── themes.dart
      │   ├── mixin/
      │   │   ├── adaptive_page_mixin.dart
      │   │   └── load_more_mixin.dart
      │   ├── routes/
      │   │   └── routes.dart
      │   ├── services/
      │   │   ├── hasura_service.dart
      │   │   ├── notifications.dart
      │   │   └── storage_services.dart
      │   ├── utils/
      │   │   ├── constants.dart
      │   │   ├── fixed_digits.dart
      │   │   ├── fixed_timer.dart
      │   │   ├── get.dart
      │   │   ├── helpers.dart
      │   │   ├── scoped_dependencies.dart
      │   │   └── obs/
      │   │       ├── list.dart
      │   │       ├── map.dart
      │   │       ├── obs.dart
      │   │       ├── rxlist.dart
      │   │       ├── rxmap.dart
      │   │       ├── rxsplay.dart
      │   │       ├── rx_sorted_map.dart
      │   │       └── sorted_map.dart
      │   └── widgets/
      │       ├── double_bounce_indicator.dart
      │       └── common_widgets/
      │           ├── gradientTextComponent.dart
      │           └── root_widget.dart
      ├── data/
      │   ├── graphql/
      │   │   ├── mutations.dart
      │   │   ├── queries.dart
      │   │   └── subscriptions.dart
      │   ├── models/
      │   │   ├── chats_model.dart
      │   │   ├── chat_message.dart
      │   │   ├── contact_model.dart
      │   │   ├── message.dart
      │   │   └── user.dart
      │   └── repositories/
      │       ├── chat_repository.dart
      │       └── user_repository.dart
      ├── presentation/
      │   ├── call/
      │   │   ├── call_state.dart
      │   │   └── call_view.dart
      │   ├── chat/
      │   │   ├── chat_binding.dart
      │   │   ├── chat_logic.dart
      │   │   ├── chat_state.dart
      │   │   └── chat_view.dart
      │   ├── chat_history/
      │   │   ├── chat_history_logic.dart
      │   │   ├── chat_history_state.dart
      │   │   └── chat_history_view.dart
      │   ├── contact/
      │   │   ├── contact_logic.dart
      │   │   ├── contact_state.dart
      │   │   └── contact_view.dart
      │   ├── home/
      │   │   ├── home_logic.dart
      │   │   ├── home_state.dart
      │   │   └── home_view.dart
      │   ├── setting/
      │   │   ├── setting_logic.dart
      │   │   ├── setting_state.dart
      │   │   └── setting_view.dart
      │   └── splash/
      │       ├── splash_binding.dart
      │       ├── splash_logic.dart
      │       ├── splash_state.dart
      │       └── splash_view.dart
      ├── screens/
      │   └── settings/
      │       ├── settings.dart
      │       └── settings_gql.dart
      └── main.dart

## معماری

این پروژه از معماری MVVM (Model-View-ViewModel) با استفاده از GetX برای مدیریت وضعیت و ناوبری استفاده می‌کند.

      Model: شامل مدل‌های داده و منطق ارتباط با سرور است.
      View: شامل ویجت‌های UI برای نمایش داده‌ها و تعامل با کاربر است.
      ViewModel: شامل کنترلرها و مدیریت وضعیت برای ارتباط بین View و Model است.

## توضیحات مهم

      GetX: برای مدیریت وضعیت، ناوبری و وابستگی‌ها استفاده شده است. 
      GraphQL: برای ارتباط با سرور و انجام کوئری‌ها و موتیشن‌ها استفاده شده است.
      Flutter Local Notifications: برای نمایش نوتیفیکیشن‌های محلی در دستگاه کاربر استفاده شده است.


