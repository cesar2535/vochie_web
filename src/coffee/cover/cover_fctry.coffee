myApp.factory 'CoverFctry', ['$rootScope', '$http', '$timeout', '$q', 'apiConfig'
($rootScope, $http, $timeout, $q, apiConfig) ->
  canceler = undefined
  getCover: (coverId, cache, product) ->
    apiKey = apiConfig.productCheck product
    if canceler
      canceler.resolve()
    canceler = $q.defer()
    $http
      url: apiConfig.rest_url '/cover/id'
      params:
        app: apiKey.app
        secret: apiKey.secret
        cover_id: coverId
      method: 'get'
      timeout: canceler.promise
    .then (successRes) ->
      console.info "----- Get Cover -----"
      console.log successRes
      return successRes.data
    , (errorRes) ->
      console.error 'abort ajx... (Get Cover)'
      console.error errorRes
      return errorRes.data
  getList: (pageSize = 10, page = 0, product = 'pop') ->
    apiKey = apiConfig.productCheck product
    if canceler
      canceler.resolve()
    canceler = $q.defer()
    $http
      url: apiConfig.rest_url '/cover/list'
      params:
        app: apiKey.app
        secret: apiKey.secret
        limit: pageSize
        page: page
      method: 'get'
      timeout: canceler.promise
    .then (successRes) ->
      console.info '----- Get Covers List -----'
      console.log successRes
      if successRes.status is 200
        return successRes.data
    , (errorRes) ->
      console.error 'abort ajax... (Cover List)'
      console.error errorRes
      return errorRes.data
  getUserCovers: (pageSize = 10, page = 0, userId, product = 'pop') ->
    apiKey = apiConfig.productCheck product
    $http
      url: apiConfig.rest_url '/cover/list'
      params:
        app: apiKey.app
        secret: apiKey.secret
        limit: pageSize
        page: page
        field: 'user_id'
        value: userId
      method: 'get'
    .then (successRes) ->
      console.info "----- Get User's Covers -----"
      console.log successRes
      if successRes.status is 200
        return successRes.data
    , (errorRes) ->
      console.error "abort ajax... (User's Covers)"
      console.error errorRes
      return errorRes.data
  searchCovers: (pageSize = 10, page = 0, type = 'title', keyword, product = 'pop') ->
    apiKey = apiConfig.productCheck product
    if canceler
      canceler.resolve()
    canceler = $q.defer()
    $http
      url: apiConfig.rest_url '/cover/search/' + type
      params:
        app: apiKey.app
        secret: apiKey.secret
        limit: pageSize
        page: page
        keyowrd: keyword
      method: 'get'
      timeout: canceler.promise
    .then (successRes) ->
      console.info "----- Search Covers -----"
      console.log successRes
      if successRes.status is 200
        return successRes.data
    , (errorRes) ->
      console.error 'abort ajax... (Search Covers)'
      console.error errorRes
      return errorRes.data
  addPlayCount: (coverId) ->
    $http
      url: apiConfig.rest_url '/cover/count/' + coverId
      params:
        token: $rootScope.user.accessToken
      method: 'get'
    .then (successRes) ->
      console.info "----- Add Play Count -----"
      console.log successRes
      if successRes.status is 200
        return successRes.data
    , (errorRes) ->
      console.error 'abort ajax... (Add Play Count)'
      console.error errorRes
      return errorRes.data
  getRecommend: (coverId, product = 'pop') ->
    apiKey = apiConfig.productCheck product
    $http
      url: apiConfig.rest_url '/cover/recommend/' + coverId
      params:
        app: apiKey.app
        secret: apiKey.secret
      method: 'get'
    .then (successRes) ->
      console.info "----- Get Recommend Covers -----"
      console.log successRes
      if successRes.status is 200
        return successRes.data
    , (errorRes) ->
      console.error "abort ajax... (Get Recommend Covers)"
      console.error errorRes
      return errorRes.data
  setStatus: (coverId, value) ->
    $http
      url: apiConfig.rest_url '/cover/set/status'
      params:
        token: $rootScope.user.accessToken
        cover_id: coverId
        value: value
      method: 'get'
    .then (successRes) ->
      console.info "----- Set Cover's Status -----"
      console.log successRes
      if successRes.status is 200
        return successRes.data
    , (errorRes) ->
      console.error "abort ajax... (Set Cover's Status)"
      console.error errorRes
      return errorRes.data
]