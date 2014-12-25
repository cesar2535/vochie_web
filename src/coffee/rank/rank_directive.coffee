myApp.directive 'HotRank', [ ->
  restrict: 'E'
  templateUrl: 'views/rank/hot.html'
  controller: 'HotCtrl'
  replace: true
]

myApp.directive 'NewRank', [ ->
  restrict: 'E'
  templateUrl: 'views/rank/new.html'
  controller: 'NewCtrl'
  replace: true
]