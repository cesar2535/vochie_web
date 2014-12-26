myApp.factory 'UserFctry', ['$rootScope', '$http', '$timeout', '$q', 'apiConfig',
($rootScope, $http, $timeout, $q, apiConfig) ->
  getUserData: (userId) ->
    subUrl = ''
    if userId
      subUrl = '/' + userId
    $http
      url: apiConfig.rest_url '/user/data' + subUrl
      params:
        token: $rootScope.user.accessToken
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