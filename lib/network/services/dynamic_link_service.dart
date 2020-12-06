part of 'services.dart';

class DynamicLinkService {
  static Future<void> retrieveDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;

        if (deepLink != null) {
          if (deepLink.queryParameters.containsKey('token')) {
            String token = deepLink.queryParameters['token'];
            StorageUtil.writeStorage('reset_token', token);

            context.bloc<PageBloc>().add(GoToResetPasswordScreen());
          }
        }
      },
      onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      },
    );
      
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      if (deepLink.queryParameters.containsKey('token')) {
        String token = deepLink.queryParameters['token'];
        StorageUtil.writeStorage('reset_token', token);

        context.bloc<PageBloc>().add(GoToResetPasswordScreen());
      }
    }
  }
}