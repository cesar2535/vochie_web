myApp.factory 'UserFctry', ['$rootScope', '$http', '$timeout', '$q', '$cookieStore', 'apiConfig', 'LoginFctry', 'LikeFctry',
($rootScope, $http, $timeout, $q, $cookieStore, apiConfig, LoginFctry, LikeFctry) ->
  console.log 'UserFctry'
  checkUserLogin: ->
    console.info "----- Check User Login -----"
    user = $cookieStore.get 'currentUser'
    if !user
      console.error 'No login user'
      $rootScope.user = {}
      user = $rootScope.user
      $cookieStore.put 'currentUser', {}

    this.getUserData undefined, user.accessToken
    .then (successRes) ->
      if successRes.msg is 'token error' or successRes.msg is 'not found user'
        console.error successRes.msg
        $rootScope.user = {}
        $cookieStore.put 'currentUser', {}
      else
        $rootScope.user = user
        $rootScope.user.accessToken = user.accessToken
        $rootScope.user.provider = user.provider
        $rootScope.user._id = successRes.data._id
        $rootScope.user.name = successRes.data.username
        $rootScope.user.profile = successRes.data
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

  setUserProfile: (field, value) ->
    $http
      url: apiConfig.rest_url '/user/set/' + field
      params:
        token: $rootScope.user.accessToken
        value: value
      method: 'get'
    .then (successRes) ->
      console.info "----- Set User's Profile -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Set User's Profile"
      console.error errorRes
      return errorRes.data

  setFollow: (userId) ->
    $http
      url: apiConfig.rest_url '/user/follow/add'
      params:
        token: $rootScope.user.accessToken
        followeduser_id: userId
      method: 'get'
    .then (successRes) ->
      console.info "----- Set Follow -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Set Follow"
      console.error errorRes
      return errorRes.data

  setUnfollow: (userId) ->
    $http
      url: apiConfig.rest_url '/user/follow/remove'
      params:
        token: $rootScope.user.accessToken
        followeduser_id: userId
      method: 'get'
    .then (successRes) ->
      console.info "----- Set Unfollow -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Set Follow"
      console.error errorRes
      return errorRes.data

  getFollowList: (userId, product = 'pop') ->
    apiKey = apiConfig.productCheck product
    $http
      url: apiConfig.rest_url '/user/followlist/2'
      params:
        app: apiKey.app
        secret: apiKey.secret
        user_id: userId
      method: 'get'
    .then (successRes) ->
      console.info "----- Get Follow List -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Get Follow List"
      console.error errorRes
      return errorRes.data

  getLoginUserPins: ->
    $http
      url: apiConfig.rest_url '/pin/mylist'
      params:
        token: $rootScope.user.accessToken
      method: 'get'
    .then (successRes) ->
      console.info "----- Get Login User Pins -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Get Login User Pins"
      console.error errorRes
      return errorRes.data
      
  getPinsList: (userId, pageSize, page, product = 'pop') ->
    apiKey = apiConfig.productCheck product
    $http
      url: apiConfig.rest_url '/user/pinlist'
      params:
        app: apiKey.app
        secret: apiKey.secret
        user_id: userId
        limit: pageSize
        page: page
      method: 'get'
    .then (successRes) ->
      console.info "----- Get Pins List -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Get Pins List"
      console.error errorRes
      return errorRes.data
]