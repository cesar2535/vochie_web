myApp = angular.module 'myApp',['ui.router','ngSanitize','ngCookies','ngAnimate','angulartics','angulartics.google.analytics','imageupload', 'seo']

myApp.constant 'apiConfig',
  server: 'http://dev2.karaokecloud.com'
  # server: 'http://api2.karaokecloud.com'
  popApp: 'lJWEvgxVzY'
  popKey: 'uit8SbrlYwxVVvdaEvjOUFxRk48RZHQuZjBRv4dtzKpugDFV0Y'
  countryApp: ''
  countryKey: ''
  rest_url: (route) ->
    return this.server + route

myApp.config ['$locationProvider','$stateProvider', '$urlRouterProvider', '$analyticsProvider','$compileProvider', '$uiViewScrollProvider', ($locationProvider, $stateProvider, $urlRouterProvider, $analyticsProvider, $compileProvider, $uiViewScrollProvider) ->
  $compileProvider.imgSrcSanitizationWhitelist(/^\s*(https?|ftp|file|blob):|data:image\//)
  $urlRouterProvider.otherwise "/hot"
  $urlRouterProvider.when '/', '/hot'
  $urlRouterProvider.when '/blog', '/blog/karaoke-news'
  $urlRouterProvider.when '/blog/', '/blog/karaoke-news'
  $locationProvider.html5Mode true
  $locationProvider.hashPrefix "!"
  $analyticsProvider.virtualPageviews(false)
  $uiViewScrollProvider.useAnchorScroll()

  $stateProvider
    .state 'root',
      url: '/'
      templateUrl: ''
      controller: ''
    .state 'cover',   # confusion
      url: '/cover/:id'
      templateUrl: ''
      controller: ''
    .state 'search',
      url: '/search/:keyword'
      templateUrl: ''
      controller: ''
    .state 'user'
      url: '/user/:id'
      templateUrl: ''
      controller: ''
    .state 'user.rec',
      url: '/records'
      templateUrl: ''
      controller: ''
    .state 'user.pin'
      url: '/pins'
      templateUrl: ''
      controller: ''
    .state 'user.follow'
      url: '/follow'
      templateUrl: ''
      controller: ''
    .state 'user.followed'
      url: '/followed'
      templateUrl: ''
      controller: ''
    .state 'pop',
      url: '/pop'
      templateUrl: ''
      controller: ''
    .state: 'pop.home',
      url: '/home'
      templateUrl: ''
      controller: ''
    .state 'pop.home.hot',
      url: '/hot'
      templateUrl: ''
      controller: ''
    .state 'pop.home.new',
      url: '/new'
      templateUrl: ''
      controller: ''
    .state: 'pop.blog'
      url: '/blog'
      templateUrl: ''
      controller: ''
    .state 'pop.songbook',
      url: '/explore'
      templateUrl: ''
      controller: ''
    .state 'country',
      url: '/country'
      templateUrl: ''
      controller: ''

]