myApp.controller 'UserCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$location', '$cookieStore', 'UserFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $location, $cookieStore, UserFctry) ->
  console.log $state

  $rootScope.title = 'User'
  $scope.userProfile = 
    _id: $stateParams.id
  $scope.isFollowing = false
  $scope.isOwner = false

  checkState = ->
    if $state.current.name is 'root.user.rec'
      $scope.state = 'records'
    else if $state.current.name is 'root.user.pin'
      $scope.state = 'pins'
    else if $state.current.name is 'root.user.follow'
      $scope.state = 'follow'
    else if $state.current.name is 'root.user.follower'
      $scope.state = 'follower'
    

  initializeUserProfile = ->
    console.log $rootScope.user
    if $rootScope.user._id
      checkIsFollowing()
    
    if $rootScope.user._id isnt $stateParams.id
      UserFctry.getUserData $stateParams.id
      .then (successRes) ->
        console.log successRes
        $scope.userProfile = successRes.data
        $scope.userProfile._id = $stateParams.id
        console.log $scope.userProfile
    else
      $scope.isOwner = true
      $scope.userProfile._id = $rootScope.user._id
      $scope.userProfile.username = $rootScope.user.name
      console.log $scope.userProfile

  checkIsFollowing = ->
    UserFctry.getFollowList $rootScope.user._id
    .then (successRes) ->
      console.log successRes
      console.log $stateParams.id
      for i in successRes.data.follow
        if i.id is $stateParams.id
          $scope.isFollowing = true

  $scope.$on '$locationChangeSuccess', ->
    checkState()
      
  checkState()
  UserFctry.checkUserLogin()
  .then (successRes) ->
    initializeUserProfile()
]