myApp.controller 'RecordingCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$cookieStore', 'UserFctry', 'CoverFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $cookieStore, UserFctry, CoverFctry) ->
  $scope.popCovers =
    list: []
    total: 0
    page: 0
  $scope.countryCovers =
    list: []
    total: 0
    page: 0

  initializeUserCovers = ->
    CoverFctry.getUserCovers 18, 0, $stateParams.id, 'pop'
    .then (successRes) ->
      console.log successRes
      if successRes.data
        $scope.popCovers.list = successRes.data.rows
        $scope.popCovers.total = successRes.data.total
      console.log $scope.popCovers
    CoverFctry.getUserCovers 18, 0, $stateParams.id, 'country'
    .then (successRes) ->
      console.log successRes
      if successRes.data
        $scope.countryCovers.list = successRes.data.rows
        $scope.countryCovers.total = successRes.data.total
      console.log $scope.countryCovers
  
  $scope.moreRecording = 
    pop: ->
      $scope.popCovers.page++
      CoverFctry.getUserCovers 18, $scope.popCovers.page, $stateParams.id, 'pop'
      .then (successRes) ->
        console.log successRes
        if successRes.data
          $scope.popCovers.list = $scope.popCovers.list.concat successRes.data.rows
          $scope.popCovers.total = successRes.data.total
        console.log $scope.popCovers
    country: ->
      $scope.countryCovers.page++
      CoverFctry.getUserCovers 18, $scope.countryCovers.page, $stateParams.id, 'country'
      .then (successRes) ->
        console.log successRes
        if successRes.data
          $scope.countryCovers.list = $scope.countryCovers.list.concat successRes.data.rows
          $scope.countryCovers.total = successRes.data.total
        console.log $scope.countryCovers

  initializeUserCovers()
]