myApp.factory 'CommentFctry', ['$rootScope', '$http', '$timeout', '$q', 'apiConfig'
($rootScope, $http, $timeout, $q, apiConfig) ->
  getCoverComments: (product = 'pop', coverId, pageSize, page) ->
    apiKey = apiConfig.productCheck product
    $http
      url: apiConfig.rest_url '/comment/list/cover'
      params:
        app: apiKey.app
        secret: apiKey.secret
        cover_id: coverId
        limit: pageSize
        page:page
      method: 'get'
    .then (successRes) ->
      console.info "----- Get Cover Comments -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Get Cover Comments"
      console.error errorRes
      return errorRes.data
  postComment: (coverId, comment) ->
    $http
      url: apiConfig.rest_url '/comment/create/cover'
      params:
        token: $rootScope.user.accessToken
        cover_id: coverId
        comment: comment
      method: 'post'
    .then (successRes) ->
      console.info "----- Post Comment -----"
      console.log successRes
      return successRes
    , (errorRes) ->
      console.error "Post Comment"
      console.error errorRes
      return errorRes.data
  removeComment: (coverId, commentId) ->
    $http
      url: apiConfig.rest_url '/comment/del/cover'
      params:
        token: $rootScope.user.accessToken
        cover_id: coverId
        id: commentId
      method: 'get'
    .then (successRes) ->
      console.info "Remove Comment"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error "Remove Comment"
      console.error errorRes
      return errorRes.data
]