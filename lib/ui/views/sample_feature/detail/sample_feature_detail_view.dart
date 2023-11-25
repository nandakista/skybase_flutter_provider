import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_notifier.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_header.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_info.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_tab.dart';
import 'package:skybase/ui/widgets/base/sky_view.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_detail.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class SampleFeatureDetailView extends StatelessWidget {
  static const String route = '/user-detail';

  const SampleFeatureDetailView({super.key, required this.usernameArgs});

  final String usernameArgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: usernameArgs),
      body: SafeArea(
        child: Consumer<SampleFeatureDetailNotifier>(
          builder: (context, notifier, child) {
            return SkyView.page(
              loadingEnabled: notifier.isLoading,
              errorEnabled: notifier.isError,
              emptyEnabled: false,
              loadingView: const ShimmerDetail(),
              errorTitle: notifier.errorMessage,
              onRefresh: () => notifier.onRefresh(),
              onRetry: () => notifier.onRefresh(),
              child: Column(
                children: [
                  SampleFeatureDetailHeader(
                    avatar: notifier.dataObj?.avatarUrl ?? '',
                    repositoryCount: notifier.dataObj?.repository ?? 0,
                    followerCount: notifier.dataObj?.followers ?? 0,
                    followingCount: notifier.dataObj?.following ?? 0,
                  ),
                  SampleFeatureDetailInfo(
                    name: notifier.dataObj?.name ?? '',
                    bio: notifier.dataObj?.bio ?? '',
                    company: notifier.dataObj?.company ?? '',
                    location: notifier.dataObj?.location ?? '',
                  ),
                  SampleFeatureDetailTab(data: notifier.dataObj),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
