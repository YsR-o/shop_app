import '../../modules/login/shop_login_screen.dart';
import '../network/local/cash_helper.dart';
import 'components.dart';

void singOut(context) {
  CashHelper.removeData(key: 'token').then(
    (value) {
      if (value) navigateAndKill(context, ShopLoginScreen());
    },
  );
}

String? token = '';
