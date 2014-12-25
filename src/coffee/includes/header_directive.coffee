myApp.directive 'PopHeader', [ ->
  restrict: 'E'
  templateUrl: 'views/pop/includes/header.html'
  controller: 'HeaderCtrl'
  replace: true
]

myApp.directive 'CountryHeader', [ ->
  restrict: 'E'
  templateUrl: 'views/country/includes/header.html'
  controller: 'HeaderCtrl'
  replace: true
]