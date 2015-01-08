myApp.controller 'PopCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'UserFctry', 'RankFctry',
($scope, $rootScope, $timeout, $q, $state, UserFctry, RankFctry) ->
  $rootScope.title = 'Vōchie POP'
  $scope.playlist = 
    hotDaily: []
    hotWeekly: []
    hotMonthly:[]
    newRank: []
]