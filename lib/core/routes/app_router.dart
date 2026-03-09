import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/services/remote_config/remote_config_service.dart';
import 'package:new_slt/features/messages/cubit/messages_cubit.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/members_cubit/members_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/messages_cubit/messages_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/members/presentation/views/send_message_admin_page.dart';
import 'package:new_slt/admin/sections/members/presentation/views/send_team_message_admin_page.dart';
import 'package:new_slt/features/posts/data/models/content_page_model.dart';
import 'package:new_slt/features/highlight_feature/data/repo/member_of_the_month_repo.dart';
import 'package:new_slt/features/highlight_feature/presentation/cubit/highlight_cubit.dart';
import 'package:new_slt/features/members/data/repos/members_repo.dart';
import 'package:new_slt/features/members/presentation/views/update_member_details_page.dart';
import 'package:new_slt/features/onboarding/presentation/views/on_boarding_page.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/data/repo/posts_repo.dart';
import 'package:new_slt/features/posts/presentation/cubits/comment_cubit/comment_cubit.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';
import 'package:new_slt/features/posts/presentation/view/content_page.dart';
import 'package:new_slt/features/posts/presentation/view/special_post_page.dart';
import 'package:new_slt/features/schedule/data/repos/schedule_repo.dart';
import 'package:new_slt/core/di/service_locator.dart';
import 'package:new_slt/features/auth/presentation/view/login_page.dart';
import 'package:new_slt/features/auth/presentation/view/register_page.dart';
import 'package:new_slt/features/campaigns/data/models/activity_model.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/features/campaigns/data/repos/campaign_repo.dart';
import 'package:new_slt/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:new_slt/features/campaigns/presentation/views/activity_page.dart';
import 'package:new_slt/features/campaigns/presentation/views/campaign_activites_page.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/features/committees/data/repos/committee_repo.dart';
import 'package:new_slt/features/committees/presentation/cubit/committee_cubit.dart';
import 'package:new_slt/features/committees/presentation/views/committee_page.dart';
import 'package:new_slt/features/council/data/repos/council_repo.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';
import 'package:new_slt/features/council/presentation/views/council_page.dart';
import 'package:new_slt/features/council/presentation/views/group_page.dart';
import 'package:new_slt/features/council/presentation/views/swa3eed_page.dart';
import 'package:new_slt/admin/data/models/choose_members_page_model.dart';
import 'package:new_slt/admin/presentation/cubits/schedule_cubit/schedule_dashboard_cubit.dart';
import 'package:new_slt/admin/presentation/shared_views/add_schedule_admin_page.dart';
import 'package:new_slt/admin/presentation/shared_views/choose_multible_members_page_admin.dart';
import 'package:new_slt/admin/presentation/shared_views/remove_schedule_admin_page.dart';
import 'package:new_slt/admin/presentation/views/dashboard_page.dart';
import 'package:new_slt/admin/presentation/shared_views/choose_member_page_admin.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/view/add_activity_admin_page.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/view/add_campaign_admin_page.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/view/campaign_activity_settings_admin.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/view/campaign_settings_admin_page.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/view/campaigns_admin_page.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/view/update_activity_details_admin_page.dart';
import 'package:new_slt/admin/sections/committees/presentation/cubit/committee_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/committees/presentation/views/add_committee_admin_page.dart';
import 'package:new_slt/admin/sections/committees/presentation/views/committee_settings_admin_page.dart';
import 'package:new_slt/admin/sections/committees/presentation/views/committees_admin_page.dart';
import 'package:new_slt/admin/sections/committees/presentation/views/update_committee_details_admin_page.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/councils/presentation/views/add_council_admin_page.dart';
import 'package:new_slt/admin/sections/councils/presentation/views/add_group_admin_page.dart';
import 'package:new_slt/admin/sections/councils/presentation/views/add_swa3ed_admin_page.dart';
import 'package:new_slt/admin/sections/councils/presentation/views/council_settings_admin_page.dart';
import 'package:new_slt/admin/sections/councils/presentation/views/councils_admin_page.dart';
import 'package:new_slt/admin/sections/councils/presentation/views/group_seetings_admin_page.dart';
import 'package:new_slt/admin/sections/councils/presentation/views/swa3ed_settings_admin_page.dart';
import 'package:new_slt/admin/sections/members/presentation/views/members_admin_page.dart';
import 'package:new_slt/admin/sections/posts/data/models/fetch_posts_page_model.dart';
import 'package:new_slt/admin/sections/posts/presentation/cubit/posts_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/posts/presentation/views/add_post_admin_page.dart';
import 'package:new_slt/admin/sections/posts/presentation/views/add_special_post_admin_page.dart';
import 'package:new_slt/admin/sections/posts/presentation/views/edit_post_admin_page.dart';
import 'package:new_slt/admin/sections/posts/presentation/views/edit_special_post_admin_page.dart';
import 'package:new_slt/admin/sections/posts/presentation/views/posts_admin_page.dart';
import 'package:new_slt/admin/sections/posts/presentation/views/fetch_posts_admin_page.dart';
import 'package:new_slt/admin/sections/schedule/presentation/views/schedule_admin_page.dart';
import 'package:new_slt/features/members/presentation/cubit/members_cubit.dart';
import 'package:new_slt/features/members/presentation/views/profile_page.dart';
import 'package:new_slt/features/messages/presentation/views/messages_page.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_page.dart';
import 'package:new_slt/features/splash/presentation/views/app_state_page.dart';
import 'package:new_slt/features/splash/presentation/views/splash_page.dart';
import 'package:new_slt/features/team_history/data/repos/team_history_repo.dart';
import 'package:new_slt/features/team_history/presentation/cubit/team_history_cubit.dart';
import 'package:new_slt/features/team_history/presentation/views/team_history_page.dart';
import 'package:new_slt/pages/activities_page.dart';
import 'package:new_slt/pages/committees_page.dart';
import 'package:new_slt/pages/home_page.dart';
import 'package:new_slt/pages/members_page.dart';

abstract class AppRouter {
  static const String kLoginPage = '/login';
  static const String kRegisterPage = '/register';
  static const String kSplashPage = '/';
  static const String kOnboardingPage = '/onboarding';
  static const String kappStatePage = '/app-state';
  //-- Main Pages
  static const String kEventsPage = '/events';
  static const String kCommitteesPage = '/committees';
  static const String kHomePage = '/home';
  static const String kMembersPage = '/members';
  static const String kActivitiesPage = '/activities';
  //-- Campaigns
  static const String kCampaignActivitiesPage = '/campaign-activities';
  static const String kActivityPage = '/activity';
  //-- Schedule
  static const String kschedulePage = '/schedule';
  //-- Posts
  static const String kPostPage = '/post';
  static const String kSpecialPostPage = '/special-post';
  //-- Committees
  static const String kCommitteePage = '/committee';
  //--  profile Page
  static const String kProfilePage = '/profile';
  static const String kUpdateProfilePage = '/update-profile';
  //-- Council
  static const String kCouncilPage = '/council';
  static const String kSwa3eedPage = '/swa3eed';
  static const String kGroupPage = '/group';
  //-- Dashboard main pages
  static const String kDashBoardPage = '/dashboard';
  static const String kChooseMemberPage = '/choose-member-admin';
  static const String kChooseMultibleMembersPage =
      '/choose-multible-members-admin';
  //-- Dashboard Committees
  static const String kCommitteesAdminPage = '/committees-admin';
  static const String kAddCommitteeAdminPage = '/add-committee-admin';
  static const String kCommitteeSettingsAdminPage = '/committee-settings-admin';
  static const String kUpdateCommitteeDetailsAdminPage =
      '/update-committee-details-admin';
  //-- Dashboard Campaigns
  static const String kCampaignsAdminPage = '/campaigns-admin';
  static const String kAddCampaignAdminPage = '/add-campaign-admin';
  static const String kCampaignSettingsAdminPage = '/campaign-settings-admin';
  static const String kAddActivityAdminPage = '/add-activity-admin';
  static const String kCampaignActivitySettingsAdminPage =
      '/campaign-activity-settings-admin';
  static const String kUpdateActivityDetailsAdminPage =
      '/update-activity-details-admin';
  //--  Dashboard councils
  static const String kCouncilsAdminPage = '/councils-admin';
  static const String kCouncilSettingsAdminPage = '/council-settings-admin';
  static const String kAddCouncilAdminPage = '/add-council-admin';
  static const String kAddSwa3edAdminPage = '/add-swa3ed-admin';
  static const String kAddGroupAdminPage = '/add-group-admin';
  static const String kSwa3edSettingsAdminPage = '/swa3ed-settings-admin';
  static const String kGroupSettingsAdminPage = '/group-settings-admin';
  //-- Dashboard schedule
  static const String kScheduleAdminPage = '/schedule-admin';
  static const String kAddMeetingAdminPage = '/add-meeting-admin';
  static const String kRemoveMeetingAdminPage = '/remove-meeting-admin';
  //-- Dashboard posts
  static const String kPostsAdminPage = '/posts-admin';
  static const String kAddPostAdminPage = '/add-post-admin';
  static const String kAddSpecialPostAdminPage = '/add-special-post-admin';
  static const String kEditSpecialPostAdminPage = '/edit-special-post-admin';
  static const String kEditPostAdminPage = '/edit-post-admin';
  static const String kFetchPostsAdminPage = '/fetch-posts-admin';
  //-- Dashboard members
  static const String kMembersAdminPage = '/members-admin';
  static const String kSendTeamMessageAdminPage = '/send-team-message-admin';
  static const String kSendMessageAdminPage = '/send-message-admin';
  //-- MessagesPage
  static const String kMessagesPage = '/messages';
  static const String kTeamHistoryPage = '/team-history';
  //-------------------------------------------
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashPage,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: kappStatePage,
        builder: (context, state) {
          final message = state.uri.queryParameters['message']!;
          final stateImage = state.uri.queryParameters['stateImage']!;
          final url = state.uri.queryParameters['url'];
          return AppStatePage(message: message, stateImage: stateImage,url: url,);
        },
      ),
      GoRoute(
        path: kRegisterPage,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: kOnboardingPage,
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(path: kLoginPage, builder: (context, state) => const LoginPage()),
      GoRoute(
        path: kDashBoardPage,
        builder: (context, state) => const DashboardPage(),
      ),
      // Choose Member page
      GoRoute(
        path: kChooseMemberPage,
        builder: (context, state) {
          final path = state.uri.queryParameters;
          return ChooseMemberPageAdmin(
            path: path['path']!,
            chooseMemberPageModel: state.extra as ChooseMembersPageModel,
          );
        },
      ),
      // Choose multible members page
      GoRoute(
        path: kChooseMultibleMembersPage,
        builder: (context, state) {
          final path = state.uri.queryParameters;
          return ChooseMultibleMembersPage(
            path: path['path']!,
            chooseMemberPageModel: state.extra as ChooseMembersPageModel,
          );
        },
      ),

      GoRoute(
        path: kschedulePage,
        builder: (context, state) {
          String path = state.uri.queryParameters["path"] ?? "";
          String docId = state.uri.queryParameters["docId"] ?? "";
          return SchedulePage(path: path, docId: docId);
        },
      ),

      GoRoute(
        path: kTeamHistoryPage,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => TeamHistoryCubit(
                    teamHistoryRepo: getItInstance.get<TeamHistoryRepo>(),
                  ),
              child: const TeamHistoryPage(),
            ),
      ),
      // Schedule Admin-
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create:
                (context) => ScheduleDashboardCubit(
                  scheduleRepo: getItInstance.get<ScheduleRepo>(),
                ),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: kScheduleAdminPage,
            builder: (context, state) => const ScheduleAdminPage(),
          ),
          GoRoute(
            path: kAddMeetingAdminPage,
            builder: (context, state) {
              final path = state.uri.queryParameters["path"] ?? "";
              final scheduleFeaturePageAdminModel =
                  state.extra as ScheduleFeaturePageAdminModel;
              return AddScheduleAdminPage(
                path: path,
                scheduleFeaturePageAdminModel: scheduleFeaturePageAdminModel,
              );
            },
          ),

          GoRoute(
            path: kRemoveMeetingAdminPage,
            builder: (context, state) {
              String path = state.uri.queryParameters["path"] ?? "";
              final scheduleFeaturePageAdminModel =
                  state.extra as ScheduleFeaturePageAdminModel;
              return RemoveScheduleAdminPage(
                scheduleFeaturePageAdminModel: scheduleFeaturePageAdminModel,

                path: path,
              );
            },
          ),
        ],
      ),
      //-- Posts Admin
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            child: child,
            create: (context) {
              return PostsDashboardCubit(
                postsRepo: getItInstance.get<PostsRepo>(),
              );
            },
          );
        },
        routes: [
          GoRoute(
            path: "$kEditPostAdminPage/:id",
            pageBuilder: (context, state) {
              String postId = state.pathParameters["id"]!;
              return CustomTransitionPage(
                child: EditPostAdminPage(postId: postId),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),
          GoRoute(
            path: kPostsAdminPage,
            builder: (context, state) => const PostsAdminPage(),
          ),
          GoRoute(
            path: kAddPostAdminPage,
            builder: (context, state) => const AddPostAdminPage(),
          ),
          GoRoute(
            path: "$kEditSpecialPostAdminPage/:id",
            builder: (context, state) {
              String postId = state.pathParameters["id"]!;
              return EditSpecialPostAdminPage(postId: postId);
            },
          ),

          GoRoute(
            path: kFetchPostsAdminPage,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: FetchPostsAdminPage(
                  showPostsPageModel: state.extra as ShowPostsPageModel,
                ),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),
          GoRoute(
            path: kAddSpecialPostAdminPage,
            builder: (context, state) => const AddSpecialPostAdminPage(),
          ),
        ],
      ),
      //-- Committee Admin
      ShellRoute(
        builder:
            (context, state, child) => BlocProvider(
              create:
                  (context) => CommitteeDashboardCubit(
                    committeeRepo: getItInstance.get<CommitteeRepo>(),
                  ),
              child: child,
            ),
        routes: [
          GoRoute(
            path: kCommitteesAdminPage,
            builder: (context, state) => const CommitteesAdminPage(),
          ),
          GoRoute(
            path: kAddCommitteeAdminPage,
            builder: (context, state) => const AddCommitteeAdminPage(),
          ),
          GoRoute(
            path: "$kCommitteeSettingsAdminPage/:id",
            builder: (context, state) {
              String committeeId = state.pathParameters["id"]!;
              return CommitteeSettingsAdminPage(committeeId: committeeId);
            },
          ),
          GoRoute(
            path: kUpdateCommitteeDetailsAdminPage,
            builder:
                (context, state) => UpdateCommitteeDetailsAdminPage(
                  committeeModel: state.extra as CommitteeModel,
                ),
          ),
        ],
      ),
      //-- Campaigns Admin
      ShellRoute(
        builder:
            (context, state, child) => BlocProvider(
              create:
                  (context) => CampaignDashbaordCubit(
                    campaignRepo: getItInstance.get<CampaignRepo>(),
                  ),
              child: child,
            ),
        routes: [
          GoRoute(
            path: kUpdateActivityDetailsAdminPage,
            builder: (context, state) {
              ActivityModel activity = state.extra as ActivityModel;
              return UpdateActivityDetailsAdminPage(activity: activity);
            },
          ),
          GoRoute(
            path: "$kCampaignActivitySettingsAdminPage/:id",
            builder: (context, state) {
              String activityId = state.pathParameters["id"]!;
              return CampaignActivitySettingsAdminPage(activityId: activityId);
            },
          ),
          GoRoute(
            path: kCampaignsAdminPage,
            builder: (context, state) => const CampaignsAdminPage(),
          ),
          GoRoute(
            path: kAddCampaignAdminPage,
            builder: (context, state) => const AddCampaignAdminPage(),
          ),
          GoRoute(
            path: "$kCampaignSettingsAdminPage/:id",
            builder: (context, state) {
              String campaignId = state.pathParameters["id"]!;
              return CampaignSettingsAdminPage(campaignId: campaignId);
            },
          ),
          GoRoute(
            path: "$kAddActivityAdminPage/:id",
            builder: (context, state) {
              String campaignId = state.pathParameters["id"]!;
              return AddActivityAdminPage(campaignId: campaignId);
            },
          ),
        ],
      ),
      // -- Councils Admin
      ShellRoute(
        builder:
            (context, state, child) => BlocProvider(
              create:
                  (context) => CouncilDashboardCubit(
                    councilRepo: getItInstance.get<CouncilRepo>(),
                  ),
              child: child,
            ),
        routes: [
          GoRoute(
            path: kCouncilsAdminPage,
            builder: (context, state) => const CouncilsAdminPage(),
          ),
          GoRoute(
            path: kAddCouncilAdminPage,
            builder: (context, state) => const AddCouncilAdminPage(),
          ),
          GoRoute(
            path: "$kCouncilSettingsAdminPage/:id",
            builder: (context, state) {
              String councilId = state.pathParameters["id"]!;
              return CouncilSettingsAdminPage(councilId: councilId);
            },
          ),
          GoRoute(
            path: kAddSwa3edAdminPage,
            builder: (context, state) => const AddSwa3edAdminPage(),
          ),
          GoRoute(
            path: kAddGroupAdminPage,
            builder: (context, state) => const AddGroupAdminPage(),
          ),
          GoRoute(
            path: kSwa3edSettingsAdminPage,
            builder: (context, state) => const Swa3edSettingsAdminPage(),
          ),
          GoRoute(
            path: kGroupSettingsAdminPage,
            builder: (context, state) => const GroupSettingsAdminPage(),
          ),
        ],
      ),
      // -- Members Admin
      ShellRoute(
        builder:
            (context, state, child) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) => MessagesDashboardCubit(
                        messageRepo: getItInstance.get<MessageRepo>(),
                      ),
                ),
                BlocProvider(
                  create:
                      (context) => MembersDashboardCubit(
                        memberOfTheMonthRepo:
                            getItInstance.get<MemberOfTheMonthRepo>(),
                        membersRepo: getItInstance.get<MembersRepo>(),
                      ),
                ),
              ],
              child: child,
            ),
        routes: [
          GoRoute(
            path: kMembersAdminPage,
            builder: (context, state) => const MembersAdminPage(),
          ),
          GoRoute(
            path: kSendTeamMessageAdminPage,
            builder: (context, state) => const SendTeamMessageAdminPage(),
          ),
          GoRoute(
            path: kSendMessageAdminPage,
            builder: (context, state) => const SendMessageAdminPage(),
          ),
        ],
      ),
      //---------------------------------------------------------------------------------
      //-- Home (Posts)
      // -- Home
      ShellRoute(
        // this will stop the transition animation
        pageBuilder:
            (context, state, child) => NoTransitionPage<void>(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => HightlightCubit(
                          remoteConfigService:
                              getItInstance.get<RemoteConfigService>(),
                          memberOfTheMonthRepo:
                              getItInstance.get<MemberOfTheMonthRepo>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => CommentCubit(
                          postsRepo: getItInstance.get<PostsRepo>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => PostsCubit(
                          postsRepo: getItInstance.get<PostsRepo>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => MessagesCubit(
                          messageRepo: getItInstance.get<MessageRepo>(),
                        ),
                  ),
                ],
                child: child,
              ),
            ),

        routes: [
          GoRoute(
            path: kMessagesPage,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage<void>(child: MessagesPage()),
          ),
          GoRoute(
            path: kHomePage,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage<void>(child: HomePage()),
          ),
          GoRoute(
            path: "$kPostPage/:id",
            builder: (context, state) {
              String postId = state.pathParameters["id"]!;
              return ContentPage(
                contentModel: state.extra as ContentPageModel,
                postID: postId,
              );
            },
          ),
          GoRoute(
            path: kSpecialPostPage,

            builder:
                (context, state) =>
                    SpecialPostPage(postModel: state.extra as PostModel),
          ),
        ],
      ),
      // -- Committee
      ShellRoute(
        pageBuilder: (context, state, child) {
          return NoTransitionPage<void>(
            child: BlocProvider(
              create:
                  (context) => CommitteeCubit(
                    committeeRepo: getItInstance.get<CommitteeRepo>(),
                  ),
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: kCommitteePage,
            builder: (context, state) {
              return CommitteePage(
                committeeModel: state.extra as CommitteeModel,
              );
            },
          ),
          GoRoute(
            path: kCommitteesPage,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage<void>(child: CommitteesPage()),
          ),
        ],
      ),
      // -- Campaigns and councils
      ShellRoute(
        pageBuilder: (context, state, child) {
          return NoTransitionPage<void>(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) => CampaignCubit(
                        campaignRepo: getItInstance.get<CampaignRepo>(),
                      ),
                ),
                BlocProvider(
                  create:
                      (context) => CouncilCubit(
                        councilRepo: getItInstance.get<CouncilRepo>(),
                      ),
                ),
              ],
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: kActivitiesPage,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: ActivitiesPage()),
          ),

          GoRoute(
            path: kCampaignActivitiesPage,
            builder: (context, state) {
              return CampaignActivitesPage(
                campaignModel: state.extra as CampaignModel,
              );
            },
          ),

          GoRoute(
            path: "$kActivityPage/:campaignId/:activityId",
            builder: (context, state) {
              String activityId = state.pathParameters["activityId"]!;
              String campaignId = state.pathParameters["campaignId"]!;

              return ActivityPage(
                activityId: activityId,
                campaignId: campaignId,
              );
            },
          ),
          GoRoute(
            path: '$kCouncilPage/:id',
            builder: (context, state) {
              final String councilId = state.pathParameters["id"]!;
              return CouncilPage(councilId: councilId);
            },
          ),

          GoRoute(
            path: kSwa3eedPage,
            builder: (context, state) => const Swa3eedPage(),
          ),

          GoRoute(
            path: "$kGroupPage/:id",
            builder: (context, state) {
              final String groupId = state.pathParameters['id']!;
              return GroupPage(groupId: groupId);
            },
          ),
        ],
      ),
      // -- Profile
      ShellRoute(
        routes: [
          GoRoute(
            path: kMembersPage,
            pageBuilder: (context, state) {
              return const NoTransitionPage<void>(child: MembersPage());
            },
          ),
          GoRoute(
            path: kUpdateProfilePage,
            builder: (context, state) => const UpdateMemberDetailsPage(),
          ),
          GoRoute(
            path: "$kProfilePage/:id",
            pageBuilder: (context, state) {
              String id = state.pathParameters['id']!;
              return CustomTransitionPage(
                child: ProfilePage(userId: id),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),
        ],
        pageBuilder:
            (context, state, child) => NoTransitionPage(
              child: BlocProvider(
                child: child,
                create:
                    (context) => MembersCubit(
                      membersRepo: getItInstance.get<MembersRepo>(),
                    ),
              ),
            ),
      ),
    ],
  );
}
