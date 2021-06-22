import 'package:flutter/material.dart';
import 'package:mobile_app_trial_1/api/accept_friend_request.dart';
import 'package:mobile_app_trial_1/api/add_user_card.dart';
import 'package:mobile_app_trial_1/api/assign_user_wallet.dart';
import 'package:mobile_app_trial_1/api/authentication.dart';
import 'package:mobile_app_trial_1/api/create_wallet_qrcode.dart';
import 'package:mobile_app_trial_1/api/get_all_friends_chat_list.dart';
import 'package:mobile_app_trial_1/api/get_all_friends_chat_list_detail.dart';
import 'package:mobile_app_trial_1/api/get_user_cards.dart';
import 'package:mobile_app_trial_1/api/get_user_messages.dart';
import 'package:mobile_app_trial_1/api/get_user_profile.dart';
import 'package:mobile_app_trial_1/api/get_user_spending.dart';
import 'package:mobile_app_trial_1/api/get_user_that_requested.dart';
import 'package:mobile_app_trial_1/api/get_user_transactions.dart';
import 'package:mobile_app_trial_1/api/get_user_wallet.dart';
import 'package:mobile_app_trial_1/api/list_friend_request.dart';
import 'package:mobile_app_trial_1/api/log_out_user.dart';
import 'package:mobile_app_trial_1/api/login_authentication.dart';
import 'package:mobile_app_trial_1/api/reject_friend_request.dart';
import 'package:mobile_app_trial_1/api/search_users.dart';
import 'package:mobile_app_trial_1/api/send_friend_request.dart';
import 'package:mobile_app_trial_1/api/top_up_wallet.dart';
import 'package:mobile_app_trial_1/api/withdraw_wallet.dart';
import 'package:mobile_app_trial_1/forms/add_card_form.dart';
import 'package:mobile_app_trial_1/pages/home.dart';
import 'package:mobile_app_trial_1/pages/qr_code_page.dart';
import 'package:mobile_app_trial_1/pages/qr_scanner_page.dart';
import 'package:mobile_app_trial_1/pages/transaction_history.dart';
import 'package:mobile_app_trial_1/screens/chat_detail_page.dart';
import 'package:mobile_app_trial_1/screens/user_cards_screen.dart';
import 'package:mobile_app_trial_1/screens/user_login_screen.dart';
import 'package:mobile_app_trial_1/screens/user_registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        ),
        ChangeNotifierProvider.value(
          value: LoginAuthentication(),
        ),
        ChangeNotifierProvider.value(
          value: AssignUserWallet(),
        ),
        ChangeNotifierProvider.value(
          value: CreateWalletQRCode(),
        ),
        ChangeNotifierProvider.value(
          value: GetUserWallet(),
        ),
        ChangeNotifierProvider.value(
          value: GetUserCards(),
        ),
        ChangeNotifierProvider.value(
          value: AddUserCard(),
        ),
        ChangeNotifierProvider.value(
          value: TopUpWallet(),
        ),
        ChangeNotifierProvider.value(
          value: WithdrawWallet(),
        ),
        ChangeNotifierProvider.value(
          value: SearchUsers(),
        ),
        ChangeNotifierProvider.value(
          value: SendFriendRequest(),
        ),
        ChangeNotifierProvider.value(
          value: ListFriendRequests(),
        ),
        ChangeNotifierProvider.value(
          value: GetUserThatRequested(),
        ),
        ChangeNotifierProvider.value(
          value: AcceptFriendRequest(),
        ),
        ChangeNotifierProvider.value(
          value: RejectFriendRequest(),
        ),
        ChangeNotifierProvider.value(
          value: GetAllFriendsChatList(),
        ),
        ChangeNotifierProvider.value(
          value: GetAllFriendsChatListDetail(),
        ),
        ChangeNotifierProvider.value(
          value: GetUserMessages(),
        ),
        ChangeNotifierProvider.value(
          value: GetUserTransactions(),
        ),
        ChangeNotifierProvider.value(
          value: GetUserSpending(),
        ),
        ChangeNotifierProvider.value(
          value: GetUserProfile(),
        ),
        ChangeNotifierProvider.value(
          value: LogOutUser(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WaiketaPay',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: UserLoginScreen(),
        routes: {
          UserRegistrationScreen.routeName: (context) => UserRegistrationScreen(),
          UserLoginScreen.routeName: (context) => UserLoginScreen(),
          Home.routeName: (context) => Home(),
          QRCodePage.routeName: (context) => QRCodePage(),
          QRScannerPage.routeName: (context) => QRScannerPage(),
          UserCardsScreen.routeName: (context) => UserCardsScreen(),
          AddCardForm.routeName: (context) => AddCardForm(),
          TransactionHistory.routeName: (context) => TransactionHistory(),
          ChatDetailPage.routeName: (context) => ChatDetailPage(),
        },
      ),
    );
  }
}
