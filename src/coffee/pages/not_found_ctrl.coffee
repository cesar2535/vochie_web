myApp.controller 'NotFoundCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state',
($scope, $rootScope, $timeout, $q, $state) ->
  $rootScope.title = 'Oops, Page Not Found!'
]