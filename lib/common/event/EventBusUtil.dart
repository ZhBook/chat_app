import 'package:event_bus/event_bus.dart';

typedef void EventCallback(event);

class EventBusUtils {
  static late EventBus _eventBus;

  static EventBus getInstance() {
    if (_eventBus == null) {
      _eventBus = new EventBus();
    }
    return _eventBus;
  }

  static void initEvenBus() {
    _eventBus = new EventBus();
    print('注册全局监听成功');
  }
}

// var eventBus = EventBusUtils;
