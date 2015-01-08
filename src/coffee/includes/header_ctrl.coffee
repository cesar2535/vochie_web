myApp.controller 'HeaderCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$location', '$cookieStore', 'LoginFctry', 'UserFctry', 'LikeFctry',
($scope, $rootScope, $timeout, $q, $state, $location, $cookieStore, LoginFctry, UserFctry, LikeFctry) ->
  $scope.location = ''
  console.log 'HeaderCtrl'
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


  getUserData = ->
    UserFctry.getUserData()
    .then (successUserRes) ->
      console.log successUserRes
      if successUserRes.status is 'success'
        $rootScope.user._id = successUserRes.data._id
        $rootScope.user.name = successUserRes.data.username
        $rootScope.user.profile = successUserRes.data
      console.log $rootScope.user
      $cookieStore.put 'currentUser', $rootScope.user
      getUserPinsList()
      getUserLikesList()

  getUserPinsList = ->
    UserFctry.getLoginUserPins()
    .then (successRes) ->
      if successRes.data?
        $rootScope.user.pinsList = successRes.data.rows
        $cookieStore.put 'currentUser', $rootScope.user

  getUserLikesList = ->
    LikeFctry.getLikesList()
    .then (successRes) ->
      if successRes.data?
        $rootScope.user.likesList = successRes.data.rows
        $cookieStore.put 'currentUser', $rootScope.user

  $scope.login = 
    withFacebook: (product) ->
      LoginFctry.loginWithFacebook product
      .then (successLoginRes) ->
        console.log successLoginRes
        getUserData()

    withTwitter: (product) ->
      LoginFctry.loginWithTwitter product, (res) ->
        console.log res
        console.log $rootScope.user
        getUserData()

  $scope.logout = ->
    LoginFctry.logout()

  $scope.$on '$locationChangeSuccess', ->
    checkLocation()

  UserFctry.checkUserLogin()
  .then (successRes) ->
    getUserData()
    checkLocation()
]