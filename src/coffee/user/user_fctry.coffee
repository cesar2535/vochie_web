myApp.factory 'UserFctry', ['$rootScope', '$http', '$timeout', '$q', '$cookieStore', 'apiConfig', 'LoginFctry'
($rootScope, $http, $timeout, $q, $cookieStore, apiConfig, LoginFctry) ->
  console.log 'UserFctry'
  checkUserLogin: ->
    user = $cookieStore.get 'currentUser'
    if user is undefined
      console.error 'No login user'
      return
    this.getUserData undefined, user.accessToken
    .then (successRes) ->
      if successRes.msg is 'token error'
        console.error successRes.msg
        $rootScope.user = {}
        $cookieStore.put 'currentUser', {}
      else
        $rootScope.user = user
        return successRes

  getUserData: (userId, accessToken) ->
    subUrl = ''
    if userId?
      subUrl = '/' + userId
      accessToken = undefined
    else if accessToken is undefined
      accessToken = $rootScope.user.accessToken
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