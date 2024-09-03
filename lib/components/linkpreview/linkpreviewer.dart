import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watfoe/theme/color_scheme.dart';

class LinkPreviewer extends StatefulWidget {
  const LinkPreviewer({super.key, required this.url});

  final String url;

  @override
  State<StatefulWidget> createState() => _LinkPreviewer();
}

class _LinkPreviewer extends State<LinkPreviewer> {
  String get url => widget.url;
  var previewData;

  @override
  Widget build(BuildContext context) {
    // Make it such clicking it opens the link

    return GestureDetector(
        onTap: () {
          _launchInBrowser(Uri.parse(url));
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          child: LinkPreview(
            enableAnimation: true,
            openOnPreviewImageTap: true,
            openOnPreviewTitleTap: true,
            onPreviewDataFetched: (data) {
              setState(() {
                previewData = data;
              });
            },
            previewData: previewData,
            text: url,
            padding: const EdgeInsets.all(0),
            previewBuilder: (_, previewData) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    previewData.image != null
                        ? CachedNetworkImage(
                            imageUrl: previewData.image!.url,
                            fit: BoxFit.contain,
                          )
                        : const SizedBox(),
                    const Gap(5),
                    Text(
                      previewData.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      previewData.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Gap(5),
                  ],
                ),
              );
            },
            linkStyle: const TextStyle(
              color: colorPrimary6,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            width: MediaQuery.of(context).size.width,
          ),
        ));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
      browserConfiguration: const BrowserConfiguration(showTitle: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
