part of '../../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @since 2023/11/07
///

/// [randomImageUrl]
Widget randomImageWidget({String? prompt, int? width, int? height}) {
  var url = randomImageUrl(prompt: prompt, width: width, height: height);
  return CachedNetworkImage(
    imageUrl: url,
    //placeholder: (context, url) => randomWidget(url),
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        const LoadingIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    fit: BoxFit.cover,
  );
}

/// [randomImagePlaceholderUrl]
Widget randomImagePlaceholderWidget() {
  var url = randomImagePlaceholderUrl();
  return CachedNetworkImage(
    imageUrl: url,
    //placeholder: (context, url) => randomWidget(url),
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        const LoadingIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    fit: BoxFit.cover,
  );
}
