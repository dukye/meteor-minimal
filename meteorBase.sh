#!/bin/bash

BIN_METEOR="meteor"

if ! which $BIN_METEOR; then
  echo ""
  echo "# ###########################################"
    echo "# "
    echo "# ERROR Meteor binary ! "
    echo "# Meteor binary file doesn't exists"
    echo "# "
  echo "# ###########################################"
  echo ""

  echo "Installing ..."
  echo ""
  curl https://install.meteor.com | /bin/sh
fi

VAR="$1"
while ! [ -z "${VAR//[a-zA-Z0-9]}" ] || [ -z $VAR ]
do
	echo ""
	echo "# ###########################################"
    echo "# "
    echo "# ERROR Meteor APPNAME ! "
    echo "# Enter a valid value or only alphanumeric characters"
    echo "# "
	echo "# ###########################################"
	echo ""
	echo "$ ./meteorBase.sh APPNAME"
	echo ""
    read VAR
done

meteor create $VAR

# Go to created meteor directory
cd $VAR

rm $VAR.*



# MOBILE CONFIG
#
# if needed
# meteor install-sdk ios
# meteor add-platform ios
# ######################################################
echo "console.log('[CLIENT] Loading home.js ...');" >> mobile-config.js 
echo "App.info({
  name: '$VAR',
  description: '$VAR iOS app built with Meteor',
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
});" >> mobile-config.js

# CLIENT
#
# Making Client directory & childs directories
# ######################################################
mkdir client
mkdir client/lib
mkdir client/templates
mkdir client/js
mkdir client/compatibility

# Making template home
echo '
<template name="home">
	<div class="container">
		<h1>Welcome home</h1>
	</div>
</template>' >> client/templates/home.html

echo "console.log('[CLIENT] Loading home.js ...');" >> client/js/home.js

# head.html
echo '
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Meteor</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=0"/>
</head>' >> client/head.html

# body.html
echo '
<body>

	<nav class="navbar navbar-default" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-id">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/">Meteor app</a>
			</div>

			<div class="collapse navbar-collapse" id="navbar-collapse-id">
				<ul class="nav navbar-nav navbar-right">
					<li class="{{ activeIfTemplateIs "Home" }}"><a href="/">Home</a></li>
				</ul>
			</div>
		</div>
	</nav>

</body>
' >> client/body.html

# main.js
echo "console.log('[CLIENT] main.* wildcard - Main.js  ...');" >> client/main.js
echo "
Template.body.helpers({
  activeIfTemplateIs: function (template) {
    var currentRoute = Router.current();
    return currentRoute && template === currentRoute.lookupTemplate() ? 'active' : '';
  }
});" >> client/main.js

echo '
{"modules": {
  "normalize":            true,
  "print":                true,

  "scaffolding":          true,
  "type":                 true,
  "code":                 true,
  "grid":                 true,
  "tables":               true,
  "forms":                true,
  "buttons":              true,

  "glyphicons":           true,
  "button-groups":        true,
  "input-groups":         true,
  "navs":                 true,
  "navbar":               true,
  "breadcrumbs":          false,
  "pagination":           false,
  "pager":                false,
  "labels":               true,
  "badges":               false,
  "jumbotron":            false,
  "thumbnails":           true,
  "alerts":               true,
  "progress-bars":        false,
  "media":                false,
  "list-group":           true,
  "panels":               false,
  "wells":                false,
  "close":                true,

  "component-animations": true,
  "dropdowns":            true,
  "modals":               false,
  "tooltip":              false,
  "popovers":             false,
  "carousel":             false,

  "affix":                false,
  "alert":                false,
  "button":               true,
  "collapse":             false,
  "scrollspy":            false,
  "tab":                  true,
  "transition":           true,

  "utilities":            false,
  "responsive-utilities": true
}}
' >> client/lib/custom.bootstrap.json


# LIBS
#
# Making lib directory
# ######################################################
mkdir lib

# Making lib files

echo "console.log('[COMMON] Loading collections.js ...');" >> lib/collections.js

echo "console.log('[COMMON] Loading routes.js ...');" >> lib/routes.js
echo "
Router.map(function () {
  this.route('home', {
    path: '/'
  });
});
" >> lib/routes.js

echo "console.log('[COMMON] Loading schema.js ...');" >> lib/schema.js
echo "
Schema = {};
" >> lib/schema.js

echo "console.log('[COMMON] Loading constants.js ...');

var \$APP_URL = Meteor.absoluteUrl();
console.log( 'const APP_URL : ' , \$APP_URL );" >> lib/constants.js



# SERVER
#
# Making server directory
# ######################################################
mkdir server

# Making server files
echo "console.log('[SERVER] Loading appStartup.js ...');" >> server/appStartup.js

echo "console.log('[SERVER] Loading server.js ...');" >> server/server.js
echo '
var environment, settings;

environment = process.env.METEOR_ENV || "development";

settings = {
  development: {
    public: {
    },
    private: {
      "mail": {
        "url": "",
        "login": "",
        "password": "",
        "port": ""
      },
      "socials": {
        "facebook": "",
        "twitter": "",
        "google": "",
        "linkedin": "",
      }
    }
  },
  staging: {
    public: {},
    private: {}
  },
  production: {
    public: {},
    private: {}
  }
};

console.log(settings);

if (!process.env.METEOR_SETTINGS) {
  console.log("No METEOR_SETTINGS passed in, using locally defined settings.");
  if (environment === "production") {
    Meteor.settings = settings.production;
  } else if (environment === "staging") {
    Meteor.settings = settings.staging;
  } else {
    Meteor.settings = settings.development;
  }
  console.log(" [ " + environment + " ] Meteor.settings");
  console.log("[Object] Settings meteor" , Meteor.settings);
}' >> server/server.js

echo "console.log('[SERVER] Loading methods.js ...');" >> server/methods.js
echo "console.log('[SERVER] Loading publish.js ...');" >> server/publish.js



# PUBLIC
#
# Making public directory
# ######################################################
mkdir public
mkdir public/images

# Making robots.txt file
echo "
User-agent :*
Disallow :

User-agent :Turnitinbot
Disallow :/

User-agent :ConveraCrawler
Disallow :/

User-agent :QuepasaCreep
Disallow :/

User-agent :Jetbot
Disallow :/
" >> public/robots.txt

# Empty favicon.ico
touch public/favicon.ico


#
# Making README.md
# ######################################################

echo "# $VAR" >> README.md
echo '
@todo

## Installation

## Changelogs

## QuickStart
### Simple
```
$ chmod +x meteorBase.sh
$ ./meteorBase.sh myapp
$ cd myapp
$ meteor
```

### Advanced

Environment : development / staging / production

1. Configure config/developement.sh with your custom vars
2. Configure config/settings.development.json with your custom vars
3. and use ...
```
$ source config/developement.sh
$ meteor --settings=config/settings.development.json
```

## Contact
' >> README.md



#
# Making config dir & files
# ######################################################
mkdir config

# Making settings.development.json
echo '{
  public: {
  },
  private: {
    "mail": {
      "protocol": "smtp://",
      "url": "",
      "login": "",
      "password": "",
      "port": ""
    },
    "socials": {
      "facebook": "",
      "twitter": "",
      "google": "",
      "linkedin": "",
    }
  }
}' >> config/settings.development.json

echo '' >> config/settings.staging.json
echo '' >> config/settings.production.json

echo '#!/bin/bash
## ######################################
## SAMPLE CONFIG
##
## export MAIL_URL="smtp://mail.free.fr"
## export MONGO_URL="mongodb://login:password@server:27017/meteor"
## export ROOT_URL="http://meteor.webetic.org"
## ######################################

export ROOT_URL="http://localhost"
export METEOR_SETTINGS="$(cat config/settings.development.json)"
export PORT="3000"
export MAIL_URL="smtp://mail.orange.fr"
' >> config/development.sh

echo $METEOR_EXPORT >> config/staging.sh
echo $METEOR_EXPORT >> config/production.sh



#
# Making tests dir
# ######################################################
mkdir tests



#
# Making private directory
# ######################################################
mkdir private

meteor add iron:router
meteor add nemo64:bootstrap less

# Aldeed packages
# collection2, simple-schema and autoform
meteor add aldeed:collection2
meteor add aldeed:simple-schema
meteor add aldeed:autoform

meteor add cfs:autoform
meteor add cfs:standard-packages
meteor add cfs:filesystem
meteor add cfs:gridfs
meteor add yogiben:autoform-file

# Accounts packages
meteor add accounts-base
meteor add accounts-password


echo ""
echo "# ###########################################"
  echo "# "
  echo "# FINISHED"
  echo "# Let's get started :"
  echo "# \$ cd $VAR"
  echo "# \$ meteor"
  echo "# "
echo "# ###########################################"
echo ""

exit;




#meteor add accounts-base
#meteor add accounts-password

#meteor add aldeed:collection2
#meteor add aldeed:simple-schema
#meteor add aldeed:autoform

#meteor add alanning:roles

#meteor remove autopublish insecure

#meteor add underscore
#meteor add cfs:autoform
#meteor add cfs:gridfs
#meteor add cfs:standard-packages
#meteor add cfs:filesystem
