myApp.controller 'HeaderCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$location', '$cookieStore', 'LoginFctry', 'UserFctry'
($scope, $rootScope, $timeout, $q, $state, $location, $cookieStore, LoginFctry, UserFctry) ->
  $scope.location = ''
  
  checkLocation = ->
    path = $location.path()
    console.log "path search: #{path}"
    console.log path.search('blog')
    if path.search('blog') > 0
      $scope.location = 'blog'
      console.log 1
    else if path.search('explore') > 0
      $scope.location = 'songbook'
      console.log 2
    else if $rootScope.user? and path.split('/')[2] is $rootScope.user._id
      $scope.location = 'user'
      console.log 3
    else
      $scope.location = ''
      console.log 4
    console.log $scope.location


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
            $rootScope.user.profile = successUserRes.data
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
            $rootScope.user.profile = successUserRes.data
          console.log $rootScope.user
          $cookieStore.put 'currentUser', $rootScope.user

  $scope.logout = ->
    LoginFctry.logout()

  $scope.$on '$locationChangeSuccess', ->
    checkLocation()

  UserFctry.checkUserLogin()
  .then (successRes) ->
    checkLocation()
]