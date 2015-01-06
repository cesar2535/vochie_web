myApp.controller 'PinsCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$cookieStore', 'UserFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $cookieStore, UserFctry) ->
  $scope.popPins = 
    list: []
    total: 0
    page: 0
  $scope.countryPins = 
    list: []
    total: 0
    page: 0

  initializeUserPins = ->
    UserFctry.getPinsList $stateParams.id, 18, 0, 'pop'
    .then (successRes) ->
      if successRes.data
        $scope.popPins.list = successRes.data.rows
        $scope.popPins.total = successRes.data.total
      console.log $scope.popPins
    UserFctry.getPinsList $stateParams.id, 18, 0, 'country'
    .then (successRes) ->
      if successRes.data
        $scope.countryPins.list = successRes.data.rows
        $scope.countryPins.total = successRes.data.total
      console.log $scope.countryPins

  $scope.morePins = 
    pop: ->
      $scope.popPins.page++
      UserFctry.getPinsList $stateParams.id, 18, $scope.popPins.page, 'pop'
      .then (successRes) ->
        if successRes.data
          $scope.popPins.list = $scope.popPins.list.concat successRes.data.rows
          $scope.popPins.total = successRes.data.total
        console.log $scope.popPins
    country: ->
      $scope.countryPins.page++
      UserFctry.getPinsList $stateParams.id, 18, $scope.countryPins.page , 'country'
      .then (successRes) ->
        if successRes.data
          $scope.countryPins.list = $scope.countryPins.list.concat successRes.data.rows
          $scope.countryPins.total = successRes.data.total
        console.log $scope.countryPins
      
  initializeUserPins()
]