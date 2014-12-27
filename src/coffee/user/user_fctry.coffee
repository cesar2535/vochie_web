myApp.factory 'UserFctry', ['$rootScope', '$http', '$timeout', '$q', '$cookieStore', 'apiConfig',
($rootScope, $http, $timeout, $q, $cookieStore, apiConfig) ->
  checkUserLogin: ->
    user = $cookieStore.get 'currentUser'
    this.getUserData undefined, user.accessToken
    .then (successRes) ->
      if successRes.msg is 'token error'
        console.error successRes.msg
        $rootScope.user = {}
        $cookieStore.put 'currentUser', {}
      else
        $rootScope.user = user

  getUserData: (userId, accessToken = $rootScope.user.accessToken) ->
    subUrl = ''
    if userId
      subUrl = '/' + userId
    $http
      url: apiConfig.rest_url '/user/data' + subUrl
      params:
        token: accessToken
      method: 'get'
    .then (successRes) ->
      console.info "----- Get User's Data -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Get User's Data"
      console.error errorRes
      return errorRes.data
]