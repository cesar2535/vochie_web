myApp.controller 'UserCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$cookieStore', 'UserFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $cookieStore, UserFctry) ->
  $rootScope.title = 'User'
  $scope.userProfile = {}
  console.log $stateParams

  initializeUserProfile = ->
    console.log $rootScope.user
    if $rootScope.user._id isnt $stateParams.id
      UserFctry.getUserData $stateParams.id
      .then (successRes) ->
        console.log successRes
        $scope.userProfile = successRes.data
        $scope.userProfile._id = $stateParams.id
        console.log $scope.userProfile
    else
      $scope.userProfile._id = $rootScope.user._id
      $scope.userProfile.username = $rootScope.user.name
      console.log $scope.userProfile

  UserFctry.checkUserLogin()
  .then (successRes) ->
    initializeUserProfile()
]