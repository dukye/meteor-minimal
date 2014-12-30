console.log('[CLIENT] Loading home.js ...');
App.info({
  name: 'myapp',
  description: 'myapp iOS app built with Meteor',
  version: '0.0.1'
});

App.icons({
  'iphone': 'public/resources/icons/icon-60.png',
  'iphone_2x': 'public/resources/icons/icon-60@2x.png'
});

App.launchScreens({
  'iphone': 'public/resources/splash/Default~iphone.png',
  'iphone_2x': 'public/resources/splash/Default@2x~iphone.png',
  'iphone5': 'public/resources/splash/Default-568h@2x~iphone.png'
});
