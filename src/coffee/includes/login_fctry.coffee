myApp.factory 'LoginFctry', ['$rootScope', '$http', '$timeout', '$q', 'apiConfig',
($rootScope, $http, $timeout, $q, apiConfig) ->
  # Initial login user's info
  $rootScope.user = {}

  firebaseRef = new Firebase apiConfig.firebase
  q = $q.defer()
  promise = q.promise
  firebaseSimpleLogin = new FirebaseSimpleLogin firebaseRef, (error, user) ->
    if error
      # an error occurred while attempting
      console.error "Simple Login"
      console.error error
      q.reject error
    else if user
      # user authenticated with Firebase
      q.resolve user
  
  oAuthFacebookWithServer = (fbToken, product = 'pop')->
    apiKey = apiConfig.productCheck product
    $http
      url: apiConfig.rest_url '/user/facebooklogin'
      params:
        fb_token: fbToken
        app: apiKey.app
        key: apiKey.secret
      method: 'get'
    .then (successRes) ->
      console.info "----- OAuth Facebook with Server -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error 'OAuth Facebook with Server'
      console.error errorRes
      return errorRes.data

  loginWithFacebook: (product = 'pop') ->
    firebaseSimpleLogin.login 'facebook',
      rememberMe: true
      scope: "email,publish_actions,user_friends,read_friendlists"
    promise.then (successRes) ->
      oAuthFacebookWithServer successRes.accessToken, product
      .then (successServerRes) ->
        $rootScope.user.accessToken = successServerRes.data

  loginWithTwitter: (product = 'pop', cb) ->
    apiKey = apiConfig.productCheck product
    twitter = window.open apiConfig.rest_url('/user/twitter?app=' + apiKey.app + '&key=' + apiKey.secret), 'twitter', 'height=400, width=600'
    window.onmessage = (e) ->
      if e.data.token?
        $rootScope.user.accessToken = e.data.token
        cb(e.data)
]