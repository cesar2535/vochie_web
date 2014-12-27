myApp.controller 'ExploreCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', 'ExploreFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, ExploreFctry) ->
  $scope.genreList = []

  if $state.current.name.search('pop') >= 0
    $rootScope.product = 
      name: 'pop'
    $scope.mainTitle = 'Vōchie Pop Song Book'
  else if $state.current.name.search('country') >= 0
    $rootScope.product =
      name: 'country'
    $scope.mainTitle = 'Vōchie Country Song Book'

  initialSongbookList = (product) ->
    ExploreFctry.getGenreList product
    .then (successRes) ->
      $scope.genreList = successRes
    ExploreFctry.getMedia product, 10, 0
    .then (successRes) ->
      console.log successRes

  initialSongbookList $rootScope.product.name
]