myApp.factory 'LikeFctry', ['$rootScope', '$http', '$q', '$timeout', 'apiConfig',
($rootScope, $http, $q, $timeout, apiConfig) ->
  like: (coverId) ->
    $http
      url: apiConfig.rest_url '/like'
      params:
        token: $rootScope.user.accessToken
        cover_id: coverId
      method: 'get'
    .then (successRes) ->
      console.info "----- Like -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Like"
      console.error errorRes
      return errorRes.data
  getLikesList: ->
    $http
      url: apiConfig.rest_url '/like/mylist'
      params:
        token: $rootScope.user.accessToken
      method: 'get'
    .then (successRes) ->
      console.info "----- Get Likes List -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Get Likes List"
      console.error errorRes
      return errorRes.data
]