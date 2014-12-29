myApp.directive 'hotRank', [ ->
  restrict: 'E'
  templateUrl: 'views/rank/rank_list.html'
  controller: 'HotCtrl'
  replace: true
  scope: true
]

myApp.directive 'newRank', [ ->
  restrict: 'E'
  templateUrl: 'views/rank/rank_list.html'
  controller: 'NewCtrl'
  replace: true
  scope: true
]