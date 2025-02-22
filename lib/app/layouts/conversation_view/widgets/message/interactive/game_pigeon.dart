import 'package:bluebubbles/app/wrappers/stateful_boilerplate.dart';
import 'package:bluebubbles/models/models.dart';
import 'package:bluebubbles/services/services.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_io/io.dart';

class GamePigeon extends StatefulWidget {
  final iMessageAppData data;
  final Message message;

  GamePigeon({
    Key? key,
    required this.data,
    required this.message,
  }) : super(key: key);

  @override
  OptimizedState createState() => _GamePigeonState();
}

class _GamePigeonState extends OptimizedState<GamePigeon> with AutomaticKeepAliveClientMixin {
  iMessageAppData get data => widget.data;
  dynamic get file => File(content.path!);
  dynamic content;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    updateObx(() async {
      final attachment = widget.message.attachments.firstOrNull;
      if (attachment != null) {
        content = as.getContent(attachment, autoDownload: true, onComplete: (file) {
          setState(() {
            content = file;
          });
        });
        if (content is PlatformFile) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content is PlatformFile && content.bytes != null)
          Image.memory(
            content.bytes!,
            gaplessPlayback: true,
            filterQuality: FilterQuality.none,
            errorBuilder: (_, __, ___) {
              return const SizedBox.shrink();
            },
          ),
        if (content is PlatformFile && content.bytes == null && content.path != null)
          Image.file(
            file,
            gaplessPlayback: true,
            filterQuality: FilterQuality.none,
            errorBuilder: (_, __, ___) {
              return const SizedBox.shrink();
            },
          ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              data.userInfo!.caption!.toUpperCase(),
              style: context.theme.textTheme.bodyMedium!.apply(fontWeightDelta: 2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
