myApp.controller 'ExploreCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', 'ExploreFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, ExploreFctry) ->
  ExploreFctry.getGenreList 'pop'
  .then (successRes) ->
    console.log successRes
  ExploreFctry.getMedia 'pop', 10, 0
  .then (successRes) ->
    console.log successRes
]