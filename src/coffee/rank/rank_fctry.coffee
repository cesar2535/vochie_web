myApp.factory 'RankFctry', ['$rootScope', '$http', '$timeout', '$q', 'apiConfig',
($rootScope, $http, $timeout, $q, apiConfig) ->
  getPlayCountRank: (type) ->
    $http
      url: apiConfig.rest_url '/rank/cover/' + type
      method: 'get'
      cache: true
    .then (successRes) ->
      if successRes.status is 200
        return successRes.data
  getLikeRank: (type) ->
    $http
      url: apiConfig.rest_url '/rank/like/' + type
      method: 'get'
      cache: true
    .then (successRes) ->
      if successRes.status is 200
        return successRes.data
  getPinRank: (type) ->
    $http
      url: apiConfig.rest_url '/rank/pin/' + type
      method: 'get'
      cache: true
    .then (successRes) ->
      if successRes.status is 200
        return successRes.data
  getAddCoverRank: (type) ->
    $http
      url: apiConfig.rest_url '/rank/addcover/' + type
      method: 'get'
      cache: true
    .then (successRes) ->
      if successRes.status is 200
        return successRes.data
  getNewStarRank: ->
    $http
      url: apiConfig.rest_url '/rank/newstar/quarter'
      method: 'get'
      cache: true
    .then (successRes) ->
      if successRes.status is 200
        return successRes.data
  getNewCovers: ->
    $http
      url: apiConfig.rest_url '/cover/newcover'
      method: 'get'
      cache: true
    .then (successRes) ->
      console.info "----- Get New Covers List -----"
      console.log successRes
      if successRes.status is 200
        return successRes.data
]