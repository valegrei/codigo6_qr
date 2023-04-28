import 'package:codigo6_qr/models/qr_model.dart';
import 'package:codigo6_qr/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonListItemWidget extends StatelessWidget {
  QRModel qrModel;

  CommonListItemWidget({
    super.key,
    required this.qrModel,
  });

  @override
  Widget build(BuildContext context) {
    bool isUrl = qrModel.url.contains("http");

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 14.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 14.0,
                      color: Colors.white54,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      qrModel.dateTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  qrModel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  qrModel.observation,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              isUrl
                  ? IconButton(
                      onPressed: () {
                        Uri uri = Uri.parse(qrModel.url);
                        launchUrl(uri, mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(
                        Icons.link,
                        color: Colors.white,
                      ))
                  : const SizedBox(),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  qrModel: qrModel,
                                )));
                  },
                  icon: const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
