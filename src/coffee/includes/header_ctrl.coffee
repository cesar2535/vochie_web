myApp.controller 'HeaderCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'LoginFctry', 'UserFctry'
($scope, $rootScope, $timeout, $q, $state, LoginFctry, UserFctry) ->

  $scope.login = 
    withFacebook: (product) ->
      LoginFctry.loginWithFacebook product
      .then (successLoginRes) ->
        console.log successLoginRes
        UserFctry.getUserData()
        .then (successUserRes) ->
          console.log successUserRes

    withTwitter: (product) ->
      LoginFctry.loginWithTwitter product, (res) ->
        console.log res
        console.log $rootScope.user
        UserFctry.getUserData()
        .then (successRes) ->
          console.log successRes
]