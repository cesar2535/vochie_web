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
    title: 'NEW COVERS'
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
            list.push 
              coverId: cover._id
              userId: cover.user_id
              title: cover.song.Title
              artist: cover.user_name
              m4a: cover.path
              playCount: cover.play_count
              likes: cover.likes
              last: cover.last
        $scope.rank.list = list.slice 0, 10
        
  getRankList()
]