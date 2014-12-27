myApp.controller 'PopCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'UserFctry', 'RankFctry',
($scope, $rootScope, $timeout, $q, $state, UserFctry, RankFctry) ->
  $rootScope.title = 'Vōchie Pop'
  $scope.playlist = 
    hotDaily: []
    hotWeekly: []
    hotMonthly:[]
    newRank: []

  UserFctry.checkUserLogin()

  RankFctry.getNewCovers()
  .then (successRes) ->
    if successRes.data
      angular.forEach successRes.data, (cover) ->
        if cover.song
          $scope.playlist.newRank.push 
            coverId: cover._id
            userId: cover.user_id
            title: cover.song.Title
            artist: cover.user_name
            m4a: cover.path
            playCount: cover.play_count
            likes: cover.likes
            last: cover.last
]