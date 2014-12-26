myApp.directive 'popHeader', [ ->
  restrict: 'EA'
  templateUrl: 'views/pop/includes/header.html'
  controller: 'HeaderCtrl'
  replace: true
]

myApp.directive 'countryHeader', [ ->
  restrict: 'EA'
  templateUrl: 'views/country/includes/header.html'
  controller: 'HeaderCtrl'
  replace: true
]

myApp.directive 'rootHeader', [ ->
  restrict: 'EA'
  templateUrl: 'views/root/includes/header.html'
  controller: 'HeaderCtrl'
  replace: true
]