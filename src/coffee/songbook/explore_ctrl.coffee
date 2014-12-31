myApp.controller 'ExploreCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', 'ExploreFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, ExploreFctry) ->
  $scope.genreList = []

  if $state.current.name.search('pop') >= 0
    $rootScope.product = 
      name: 'pop'
    $scope.mainTitle = 'Vōchie Pop Song Book'
    $scope.description = 
      text: 'more country songs'
      link: "country.songbook"
    $rootScope.title = 'Vōchie Pop - Song Book'
  else if $state.current.name.search('country') >= 0
    $rootScope.product =
      name: 'country'
    $scope.mainTitle = 'Vōchie Country Song Book'
    $scope.description = 
      text: 'more pop songs'
      link: "pop.songbook"
    $rootScope.title = 'Vōchie Country - Song Book'

  initializeSongbookList = (product) ->
    ExploreFctry.getGenreList product
    .then (successRes) ->
      $scope.genreList = successRes
    ExploreFctry.getMedia product, 10, 0
    .then (successRes) ->
      console.log successRes

  initializeSongbookList $rootScope.product.name
]