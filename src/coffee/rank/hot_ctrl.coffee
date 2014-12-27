myApp.controller 'HotCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', 'apiConfig', 'RankFctry',
($scope, $rootScope, $timeout, $q, $state, apiConfig, RankFctry) ->
  if $state.current.name is 'pop.hot'
    $rootScope.product =
      name: 'pop'
      app: apiConfig.popApp
      secret: apiConfig.popKey
  else if $state.current.name is 'country.hot'
    $rootScope.product =
      name: 'country'
      app: apiConfig.countryApp
      secret: apiConfig.countryKey
]