myApp.controller 'HeaderCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$cookieStore', 'LoginFctry', 'UserFctry'
($scope, $rootScope, $timeout, $q, $state, $cookieStore, LoginFctry, UserFctry) ->

  $scope.login = 
    withFacebook: (product) ->
      LoginFctry.loginWithFacebook product
      .then (successLoginRes) ->
        console.log successLoginRes
        UserFctry.getUserData()
        .then (successUserRes) ->
          console.log successUserRes
          if successUserRes.status is 'success'
            $rootScope.user._id = successUserRes.data._id
            $rootScope.user.name = successUserRes.data.username
          console.log $rootScope.user
          $cookieStore.put 'currentUser', $rootScope.user

    withTwitter: (product) ->
      LoginFctry.loginWithTwitter product, (res) ->
        console.log res
        console.log $rootScope.user
        UserFctry.getUserData()
        .then (successRes) ->
          console.log successRes
          if successRes.status is 'success'
            $rootScope.user._id = successRes.data._id
            $rootScope.user.name = successRes.data.username
          console.log $rootScope.user
          $cookieStore.put 'currentUser', $rootScope.user

  $scope.logout = ->
    LoginFctry.logout()
]