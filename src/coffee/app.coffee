myApp = angular.module 'myApp',['ui.router','ngSanitize','ngCookies','ngAnimate','angulartics','angulartics.google.analytics','imageupload', 'seo']

myApp.constant 'apiConfig',
  firebase: 'https://singnshare.firebaseio.com'
  # server: 'https://dev2.karaokecloud.com'
  server: 'https://api2.karaokecloud.com'
  app: 'lJWEvgxVzY'
  key: 'uit8SbrlYwxVVvdaEvjOUFxRk48RZHQuZjBRv4dtzKpugDFV0Y'
  popApp: '1bVMwIJS6h'
  popKey: 'ZWgCj2EGOje1FUwd0KYX8Z93LFLvyQNyN4a76ONT93TNXp2801'
  countryApp: '7I6DYCk84B'
  countryKey: 'llAVWp9LerYtkOtDWIJkSP4Xt3AO0Epu11qWqyIEZG9jvBXrkG'
  rest_url: (route) ->
    return this.server + route
  productCheck: (product) ->
    product = product.toLowerCase()
    apiKey = {}
    switch product
      when 'country'
        apiKey.name = 'country'
        apiKey.app = this.countryApp
        apiKey.secret = this.countryKey
        return apiKey
      when 'pop'
        apiKey.name = 'pop'
        apiKey.app = this.popApp
        apiKey.secret = this.popKey
        return apiKey
      else
        apiKey.name = 'pop'
        apiKey.app = this.popApp
        apiKey.secret = this.popKey
        return apiKey

myApp.config ['$locationProvider','$stateProvider', '$urlRouterProvider', '$analyticsProvider','$compileProvider', '$uiViewScrollProvider', 
($locationProvider, $stateProvider, $urlRouterProvider, $analyticsProvider, $compileProvider, $uiViewScrollProvider) ->
  $compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)
  $urlRouterProvider.otherwise "/"
  $urlRouterProvider.when '/', '/home'
  $urlRouterProvider.when '/pop', '/pop/home'
  $urlRouterProvider.when '/country', '/country/home'
  $locationProvider.html5Mode true
  $locationProvider.hashPrefix "!"
  $analyticsProvider.virtualPageviews(false)
  $uiViewScrollProvider.useAnchorScroll()

  $stateProvider
    .state 'root',
      url: '/'
      templateUrl: 'views/root/pages/layout.html'
      controller: 'RootCtrl'
    .state 'root.home',
      url: 'home'
      templateUrl: 'views/root/pages/home.html'
    .state 'root.blog',
      url: 'blog'
      templateUrl: 'views/root/pages/blog.html'
      controller: ''
    .state 'cover',   # confusion
      url: '/cover/:id'
      templateUrl: ''
      controller: ''
    .state 'search',
      url: '/search/:keyword'
      templateUrl: ''
      controller: ''
    .state 'user',
      url: '/user/:id'
      templateUrl: 'views/user/user.html'
      controller: 'UserCtrl'
    .state 'user.rec',
      url: '/records'
      templateUrl: ''
      controller: ''
    .state 'user.pin',
      url: '/pins'
      templateUrl: ''
      controller: ''
    .state 'user.follow',
      url: '/follow'
      templateUrl: ''
      controller: ''
    .state 'user.followed',
      url: '/followed'
      templateUrl: ''
      controller: ''
    .state 'pop',
      url: '/pop'
      templateUrl: 'views/pop/pages/layout.html'
      controller: ''
    .state 'pop.home',
      url: '/home'
      templateUrl: 'views/pop/pages/home.html'
      controller: ''
    .state 'pop.home.hot',
      url: '/hot'
      templateUrl: ''
      controller: ''
    .state 'pop.home.new',
      url: '/new'
      templateUrl: ''
      controller: ''
    .state 'pop.songbook',
      url: '/explore'
      templateUrl: 'views/songbook/songbook.html'
      controller: 'ExploreCtrl'
    .state 'country',
      url: '/country'
      templateUrl: 'views/country/pages/layout.html'
      controller: ''
    .state 'country.home',
      url: '/home'
      templateUrl: 'views/country/pages/home.html'
      controller: ''
    .state 'country.songbook',
      url: '/explore'
      templateUrl: '/views/songbook/songbook.html'
      controller: 'ExploreCtrl'
]