myApp = angular.module 'myApp',['ui.router','ngSanitize','ngCookies','ngAnimate','angulartics','angulartics.google.analytics','imageupload', 'seo']

myApp.constant 'apiConfig',
  firebase: 'https://singnshare.firebaseio.com'
  server: 'https://dev2.karaokecloud.com'
  # server: 'https://api2.karaokecloud.com'
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
        apiKey.app = this.countryApp
        apiKey.secret = this.countryKey
        return apiKey
      when 'pop'
        apiKey.app = this.popApp
        apiKey.secret = this.popKey
        return apiKey
      else
        apiKey.app = this.popApp
        apiKey.secret = this.popKey
        return apiKey

myApp.config ['$locationProvider','$stateProvider', '$urlRouterProvider', '$analyticsProvider','$compileProvider', '$uiViewScrollProvider', 
($locationProvider, $stateProvider, $urlRouterProvider, $analyticsProvider, $compileProvider, $uiViewScrollProvider) ->
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
    .state 'user',
      url: '/user/:id'
      templateUrl: ''
      controller: ''
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
    .state 'pop.blog',
      url: '/blog'
      templateUrl: ''
      controller: ''
    .state 'pop.songbook',
      url: '/explore'
      templateUrl: ''
      controller: ''
    .state 'country',
      url: '/country'
      templateUrl: 'views/country/pages/layout.html'
      controller: ''

]