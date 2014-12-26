myApp.directive 'notification', [ ->
  restrict: 'EA'
  templateUrl: 'views/user/notification.html'
  controller: 'NotificationCtrl'
  replace: true
]

myApp.controller 'NotificationCtrl', ['$scope', '$rootScope', '$timeout', '$q',
($scope, $rootScope, $timeout, $q) ->

]