myApp.controller 'FollowCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', '$cookieStore', 'UserFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, $cookieStore, UserFctry) ->
  $scope.followList =
    follow: []
    followed: []

  initializeFollowList = ->
    UserFctry.getFollowList $stateParams.id, 'pop'
    .then (successRes) ->
      console.log successRes
      if successRes.data
        $scope.followList.follow = successRes.data.follow
        $scope.followList.followed = successRes.data.followed
      console.log $scope.followList

  initializeFollowList()
]