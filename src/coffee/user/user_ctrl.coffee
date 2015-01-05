myApp.controller 'UserCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$location', '$cookieStore', 'UserFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $location, $cookieStore, UserFctry) ->
  console.log $state

  $rootScope.title = 'User'
  $scope.userProfile = 
    _id: $stateParams.id
  $scope.editMode = 
    profile: false
    email: false
  $scope.editProfile = {}
  $scope.isFollowing = false
  $scope.isOwner = false
  $scope.emailStatus = undefined

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
    
    if $rootScope.user._id isnt $stateParams.id
      UserFctry.getUserData $stateParams.id
      .then (successRes) ->
        console.log successRes
        $scope.userProfile = successRes.data
        $scope.userProfile._id = $stateParams.id
        console.log $scope.userProfile
      checkIsFollowing()
    else
      $scope.isOwner = true
      $scope.userProfile = $rootScope.user.profile
      console.log $scope.userProfile
      if $scope.userProfile.public_email is 0 or $scope.userProfile.public_email is false
        $scope.emailStatus = false
      else if $scope.userProfile.public_email is 1 or $scope.userProfile.public_email is true
        $scope.emailStatus = true

  checkIsFollowing = ->
    UserFctry.getFollowList $rootScope.user._id
    .then (successRes) ->
      console.log successRes
      console.log $stateParams.id
      for i in successRes.data.follow
        if i.id is $stateParams.id
          $scope.isFollowing = true

  $scope.editFunc = 
    setEmailStatus: (status) ->
      if status
        UserFctry.setUserProfile 'public_email', 1
        .then (successRes) ->
          console.log successRes
          if successRes.msg is 'updated success'
            $rootScope.user.profile.public_email = '1'
            $scope.emailStatus = true
      else
        UserFctry.setUserProfile 'public_email', 0
        .then (successRes) ->
          console.log successRes
          if successRes.msg is 'updated success'
            $rootScope.user.profile.public_email = '0'
            $scope.emailStatus = false
    setEmail: (editMode) ->
      if !editMode
        UserFctry.setUserProfile 'email', $scope.userProfile.email
        .then (successRes) ->
          console.log successRes
          if successRes.msg is 'updated success'
            $rootScope.user.profile.email = $scope.userProfile.email
    setUsername: (editMode) ->
      if !editMode
        console.log $scope.userProfile.username
        UserFctry.setUserProfile 'username', $scope.userProfile.username
        .then (successRes) ->
          console.log successRes
          if successRes.msg is 'updated success'
            $rootScope.user.name = $scope.userProfile.username
            $rootScope.user.profile.username = $scope.userProfile.username
    setDescription: (editMode) ->
      if !editMode
        console.log $scope.userProfile
        UserFctry.setUserProfile 'profile', $scope.userProfile.profile
        .then (successRes) ->
          console.log successRes
          if successRes.msg is 'updated success'
            $rootScope.user.profile.profile = $scope.userProfile.profile

  $scope.follow = ->
    UserFctry.setFollow $stateParams.id
    .then (successRes) ->
      console.log successRes
      if successRes.msg is 'follow success'
        $scope.isFollowing = true

  $scope.unfollow = ->
    UserFctry.setUnfollow $stateParams.id
    .then (successRes) ->
      console.log successRes
      if successRes.msg is 'follow success'
        $scope.isFollowing = false

  $scope.$on '$locationChangeSuccess', ->
    checkState()
      
  checkState()
  UserFctry.checkUserLogin()
  .then (successRes) ->
    initializeUserProfile()
]