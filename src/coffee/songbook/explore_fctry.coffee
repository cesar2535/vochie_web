myApp.factory 'ExploreFctry', ['$rootScope', '$http', '$timeout', '$q', 'apiConfig',
($rootScope, $http, $timeout, $q, apiConfig) ->
  canceler = undefined
  getGenreList: (product = 'pop') ->
    apiKey = apiConfig.productCheck product
    genreList = []
    $http
      url: apiConfig.rest_url '/media/genrelist'
      params:
        app: apiKey.app
        secret: apiKey.secret
      method: 'get'
      cache: true
    .then (successRes) ->
      console.info "----- Get Gernre List -----"
      console.log successRes
      if successRes.data
        genreTemp = successRes.data.data.rows
        genreTemp.pop()
        genreTemp.pop()
        angular.forEach genreTemp, (item, index) ->
          angular.forEach item, (value, key) ->
            genreList.push 
              category: key
              count: value
        genreList.sort (first, second) ->
          second.count - first.count
      return genreList
    , (errorRes) ->
      console.error "Get Genre List"
      console.error errorRes
      return errorRes.data
  getMedia: (product = 'pop', pageSize, page, genre, title, artistName, sort = 'Title:1') ->
    apiKey = apiConfig.productCheck product
    if canceler
      canceler.resolve()
    canceler = $q.defer()
    $http
      url: apiConfig.rest_url '/media'
      params:
        app: apiKey.app
        secret: apiKey.secret
        limit: pageSize
        page: page
        title: title
        artistname: artistName
        sort: sort
      timeout: canceler.promise
      method: 'get'
      cache: true
    .then (successRes) ->
      console.info "----- Get Media -----"
      console.log successRes
      return successRes.data
]