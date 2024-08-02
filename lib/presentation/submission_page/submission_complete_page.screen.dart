// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/common_widget/custom_button.dart';

import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import '../common_widget/text_background.dart';
import 'controllers/submission_page.controller.dart';

class SubmissionCompletePageScreem extends GetView<SubmissionPageController> {
  const SubmissionCompletePageScreem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BackAppbar(titleAppbar: 'Pengumpulan Tugas'),
        ),
        
    );
  }
}
