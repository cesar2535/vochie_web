myApp.controller 'HotCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'apiConfig', 'RankFctry',
($scope, $rootScope, $timeout, $q, $state, apiConfig, RankFctry) ->
  if $state.current.name is 'pop.home'
    $rootScope.product =
      name: 'pop'
      app: apiConfig.popApp
      secret: apiConfig.popKey
    $scope.coverLink = 'pop.cover'
    $rootScope.title = 'Vōchie Pop'
  else if $state.current.name is 'country.home'
    $rootScope.product =
      name: 'country'
      app: apiConfig.countryApp
      secret: apiConfig.countryKey
    $scope.coverLink = 'country.cover'
    $rootScope.title = 'Vōchie Country'

  $scope.rank = 
    title: 'HOT COVERS'
    type: 'hot'
    subType: ''
    list: []

  getRankList = (type) ->
    RankFctry.getPlayCountRank type
    .then (successRes) ->
      console.log successRes
      list = []
      angular.forEach successRes.data.rows, (item) ->
        list.push
          coverId: item.id
          userId: item.song.user_id
          username: item.song.user_name
          title: item.song.song.Title
          artist: item.song.user_name
          m4a: item.song.path
          playCount: item.count
          likes: item.song.likes.total
          last: item.last
      $scope.rank.list = list.slice 0, 10

  $scope.changeSubType = (subType) ->
    subType = subType.toLowerCase()
    if subType is 'daily'
      getRankList 'day'
      .then (successRes) ->
        $scope.rank.subType = subType
    else if subType is 'weekly'
      getRankList 'week'
      .then (successRes) ->
        $scope.rank.subType = subType
    else if subType is 'monthly'
      getRankList 'month'
      .then (successRes) ->
        $scope.rank.subType = subType

  $scope.playback = (item) ->
    if myPlaylist.playlist.length is 0
      myPlaylist.setPlaylist [item]
    else 
      myPlaylist.add item
    $rootScope.initPlayer = true
    console.log myPlaylist

  $scope.changeSubType 'daily'
]