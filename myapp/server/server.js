console.log('[SERVER] Loading server.js ...');

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
}
