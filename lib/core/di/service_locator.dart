import 'package:get_it/get_it.dart';
import 'package:new_slt/core/services/auth/auth_service.dart';
import 'package:new_slt/core/services/auth/firebase_auth_service.dart';
import 'package:new_slt/core/services/cloud/cloudinary_service.dart';
import 'package:new_slt/core/services/cloud/storage_service.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/services/database/firestore_service.dart';
import 'package:new_slt/core/services/notification/firebase_messaging.dart';
import 'package:new_slt/core/services/notification/notification_service.dart';
import 'package:new_slt/core/services/remote_config/firebase_remote_config.dart';
import 'package:new_slt/core/services/remote_config/remote_config_service.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/features/messages/data/repos/message_repo_impl.dart';
import 'package:new_slt/features/highlight_feature/data/repo/member_of_the_month_repo.dart';
import 'package:new_slt/features/highlight_feature/data/repo/member_of_the_month_repo_impl.dart';
import 'package:new_slt/features/members/data/repos/members_repo.dart';
import 'package:new_slt/features/members/data/repos/members_repo_impl.dart';
import 'package:new_slt/features/posts/data/repo/posts_repo.dart';
import 'package:new_slt/features/posts/data/repo/posts_repo_impl.dart';
import 'package:new_slt/features/schedule/data/repos/schedule_repo.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/features/user/data/repos/user_repo_impl.dart';
import 'package:new_slt/features/campaigns/data/repos/campaign_repo.dart';
import 'package:new_slt/features/campaigns/data/repos/campaign_repo_impl.dart';
import 'package:new_slt/features/committees/data/repos/committee_repo.dart';
import 'package:new_slt/features/committees/data/repos/committee_repo_impl.dart';
import 'package:new_slt/features/council/data/repos/council_repo.dart';
import 'package:new_slt/features/council/data/repos/council_repo_impl.dart';
import 'package:new_slt/features/schedule/data/repos/schedule_repo_impl.dart';
import 'package:new_slt/features/team_history/data/repos/team_history_repo.dart';
import 'package:new_slt/features/team_history/data/repos/team_history_repo_impl.dart';

final getItInstance = GetIt.instance;

void setupServiceLocator() {
  // --Database
  getItInstance.registerSingleton<DatabaseService>(FirestoreService());
  // Notification
  getItInstance.registerSingleton<NotificationService>(
    FirebaseMessaggingService(db: getItInstance.get<DatabaseService>()),
  );
  // -- Remote Config
  getItInstance.registerSingleton<RemoteConfigService>(
    FirebaseRemoteConfigService(),
  );
  // --Auth
  getItInstance.registerSingleton<AuthService>(
    FirebaseAuthService(
      notificationService: getItInstance.get<NotificationService>(),
      db: getItInstance.get<DatabaseService>(),
    ),
  );
  // --Storage
  getItInstance.registerSingleton<StorageService>(CloudinaryService());

  // --Users
  getItInstance.registerSingleton<UserRepo>(
    UserRepoImpl(db: getItInstance.get<DatabaseService>()),
  );
  // --Messages
  getItInstance.registerSingleton<MessageRepo>(
    MessageRepoImpl(
      userRepo: getItInstance.get<UserRepo>(),
      notificationService: getItInstance.get<NotificationService>(),
      db: getItInstance.get<DatabaseService>(),
    ),
  );
  // --Posts
  getItInstance.registerSingleton<PostsRepo>(
    PostsRepoImpl(
      messageRepo: getItInstance.get<MessageRepo>(),
      notificationService: getItInstance.get<NotificationService>(),
      db: getItInstance.get<DatabaseService>(),
      userRepo: getItInstance.get<UserRepo>(),
    ),
  );
  // --Schedules
  getItInstance.registerSingleton<ScheduleRepo>(
    ScheduleRepoImpl(
      notificationService: getItInstance.get<NotificationService>(),
      messageRepo: getItInstance.get<MessageRepo>(),
      db: getItInstance.get<DatabaseService>(),
      userRepo: getItInstance.get<UserRepo>(),
    ),
  );
  // --Committees
  getItInstance.registerSingleton<CommitteeRepo>(
    CommitteeRepoImpl(
      messageRepo: getItInstance.get<MessageRepo>(),
      db: getItInstance.get<DatabaseService>(),
      userRepo: getItInstance.get<UserRepo>(),
    ),
  );
  // --Campaigns
  getItInstance.registerSingleton<CampaignRepo>(
    CampaignRepoImpl(
      messageRepo: getItInstance.get<MessageRepo>(),
      db: getItInstance.get<DatabaseService>(),
      userRepo: getItInstance.get<UserRepo>(),
    ),
  );
  // --Councils
  getItInstance.registerSingleton<CouncilRepo>(
    CouncilRepoImpl(
      messageRepo: getItInstance.get<MessageRepo>(),
      db: getItInstance.get<DatabaseService>(),
      userRepo: getItInstance.get<UserRepo>(),
    ),
  );
  // --Members
  getItInstance.registerSingleton<MembersRepo>(
    MembersRepoImpl(
      userRepo: getItInstance.get<UserRepo>(),
      messageRepo: getItInstance.get<MessageRepo>(),
      db: getItInstance.get<DatabaseService>(),
    ),
  );
  // --Team History
  getItInstance.registerSingleton<TeamHistoryRepo>(
    TeamHistoryRepoImpl(db: getItInstance.get<DatabaseService>()),
  );
  // --Member of the month
  getItInstance.registerSingleton<MemberOfTheMonthRepo>(
    MemberOfTheMonthRepoImpl(
      messageRepo: getItInstance.get<MessageRepo>(),
      db: getItInstance.get<DatabaseService>(),
    ),
  );
}
