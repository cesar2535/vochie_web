myApp.controller 'PinsCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$cookieStore', 'UserFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $cookieStore, UserFctry) ->
  $scope.popPins = 
    list: []
    total: 0
  $scope.countryPins = 
    list: []
    total: 0

  initializeUserPins = ->
    UserFctry.getPinsList $stateParams.id, 18, 0, 'pop'
    .then (successRes) ->
      if successRes.data.length > 0
        $scope.popPins.list = successRes.data.rows
        $scope.popPins.total = successRes.data.total
      console.log $scope.popPins
    UserFctry.getPinsList $stateParams.id, 18, 0, 'country'
    .then (successRes) ->
      if successRes.data.length > 0
        $scope.countryPins.list = successRes.data.rows
        $scope.countryPins.total = successRes.data.total
      console.log $scope.countryPins
      
  initializeUserPins()
]