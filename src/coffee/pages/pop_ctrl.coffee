myApp.controller 'PopCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'UserFctry', 'RankFctry',
($scope, $rootScope, $timeout, $q, $state, UserFctry, RankFctry) ->
  $rootScope.title = 'Vōchie Pop'
  $scope.playlist = 
    hotDaily: []
    hotWeekly: []
    hotMonthly:[]
    newRank: []

  UserFctry.checkUserLogin()
]