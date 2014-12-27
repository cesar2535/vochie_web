myApp.controller 'CountryCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'UserFctry',
($scope, $rootScope, $timeout, $q, $state, UserFctry) ->
  $rootScope.title = 'Vōchie Country'

  UserFctry.checkUserLogin()
]