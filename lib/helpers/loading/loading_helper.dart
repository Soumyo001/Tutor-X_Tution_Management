import 'dart:async';

import 'package:flutter/Material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:tutor_x_tution_management/controllers/loading_controller.dart';

class LoadingHelper {
  LoadingHelper._sharedInstance();
  static final _shared = LoadingHelper._sharedInstance();
  factory LoadingHelper() => _shared;

  LoadingController? loadingController;

  void show(BuildContext context, String text) {
    if (loadingController?.updateLoadingScreen(text) ?? false) {
      return;
    } else {
      loadingController = showOverlay(context: context, text: text);
    }
  }

  void close() {
    loadingController?.closeLoadingScreen();
    loadingController = null;
  }

  LoadingController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.grey.shade300.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SpinKitSpinningCircle(
                    color: Colors.red,
                  ),
                  const Gap(10),
                  StreamBuilder(
                    stream: _text.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);
    return LoadingController(
      updateLoadingScreen: (p0) {
        _text.add(p0);
        return true;
      },
      closeLoadingScreen: () {
        _text.close();
        overlay.remove();
        return true;
      },
    );
  }
}
