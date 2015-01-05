myApp.controller 'RecordingCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$cookieStore', 'UserFctry', 'CoverFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $cookieStore, UserFctry, CoverFctry) ->
  $scope.popCovers =
    list: []
    total: 0
  $scope.countryCovers =
    list: []
    total: 0

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
          
        

  initializeUserCovers()
]