myApp.controller 'NewCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'apiConfig', 'RankFctry',
($scope, $rootScope, $timeout, $q, $state, apiConfig, RankFctry) ->
  if $state.current.name is 'pop.home'
    $rootScope.product =
      name: 'pop'
      app: apiConfig.popApp
      secret: apiConfig.popKey
    $scope.coverLink = 'pop.cover'
  else if $state.current.name is 'country.home'
    $rootScope.product =
      name: 'country'
      app: apiConfig.countryApp
      secret: apiConfig.countryKey
    $scope.coverLink = 'country.cover'

  $scope.rank = 
    title: "WHAT'S NEW"
    type: 'new'
    subType: ''
    list: []

  getRankList = (type) ->
    RankFctry.getNewCovers()
    .then (successRes) ->
      list = []
      if successRes.data
        angular.forEach successRes.data, (cover) ->
          if cover.song
            path = cover.path.replace 'http://voice.karaokecloud.com', 'https://d9rqh24few3wz.cloudfront.net'
            list.push 
              coverId: cover._id
              userId: cover.user_id
              username: cover.user_name
              title: cover.song.Title
              artist: cover.user_name
              m4a: path
              playCount: cover.play_count
              likes: cover.likes
              last: cover.last
        $scope.rank.list = list.slice 0, 10
  
  $scope.playback = (item) ->
    if myPlaylist.playlist.length is 0
      myPlaylist.setPlaylist [item]
    else 
      myPlaylist.add item
    $rootScope.initPlayer = true

  getRankList()
]