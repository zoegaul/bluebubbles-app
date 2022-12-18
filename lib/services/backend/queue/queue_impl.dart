import 'dart:async';

import 'package:bluebubbles/helpers/helpers.dart';
import 'package:bluebubbles/models/models.dart';
import 'package:bluebubbles/services/services.dart';
import 'package:bluebubbles/utils/logger.dart';
import 'package:get/get.dart';

abstract class Queue extends GetxService {
  bool isProcessing = false;
  List<QueueItem> items = [];

  Future<void> queue(QueueItem item) async {
    Logger.info("Prepping...");
    final returned = await prepItem(item);
    // we may get a link split into 2 messages
    if (item is OutgoingItem && returned is List) {
      items.addAll(returned.map((e) => OutgoingItem(
        type: QueueType.sendMessage,
        chat: item.chat,
        message: e,
        completer: item.completer,
        selected: item.selected,
        reaction: item.reaction,
      )));
    } else {
      Logger.info("Adding to queue list...");
      items.add(item);
    }
    Logger.info("Processing... (Is processing: $isProcessing)");
    Logger.info("List of items: $items");
    Logger.info("Condition: ${items.isEmpty && item is IncomingItem}");
    if (!isProcessing || (items.isEmpty && item is IncomingItem)) processNextItem();
  }

  Future<dynamic> prepItem(QueueItem _);

  Future<void> processNextItem() async {
    if (items.isEmpty) {
      Logger.info("No more items!");
      isProcessing = false;
      return;
    }

    isProcessing = true;
    Logger.info("Removing from list...");
    QueueItem queued = items.removeAt(0);

    try {
      Logger.info("Handling item...");
      await handleQueueItem(queued).catchError((err) async {
        if (queued is OutgoingItem && ss.settings.cancelQueuedMessages.value) {
          final toCancel = List<OutgoingItem>.from(items.whereType<OutgoingItem>().where((e) => e.chat.guid == queued.chat.guid));
          for (OutgoingItem i in toCancel) {
            items.remove(i);
            final m = i.message;
            final tempGuid = m.guid;
            m.guid = m.guid!.replaceAll("temp", "error-Canceled due to previous failure");
            m.error = MessageError.BAD_REQUEST.code;
            Message.replaceMessage(tempGuid, m);
          }
        }
      });
      queued.completer?.complete();
    } catch (ex, stacktrace) {
      Logger.error("Failed to handle queued item! $ex");
      Logger.error(stacktrace.toString());
      queued.completer?.completeError(ex);
    }
    Logger.info("Processing next item...");
    await processNextItem();
  }

  Future<void> handleQueueItem(QueueItem _);
}
