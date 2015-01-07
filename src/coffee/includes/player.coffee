myPlaylist = undefined

myApp.directive 'jplayer', [ ->
  restrict: 'EA'
  templateUrl: 'views/player/player.html'
  controller: 'PlayerCtrl'
  replace: true
]

myApp.controller 'PlayerCtrl', ['$scope', '$rootScope', '$timeout', '$q', 
($scope, $rootScope, $timeout, $q) ->

  $(document).ready ->
    is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1
    is_safari = navigator.userAgent.toLowerCase().indexOf('safari') > -1

    if is_safari or is_chrome
      myPlaylist = new jPlayerPlaylist 
        jPlayer: "#jquery_jplayer_1"
        cssSelectorAncestor: "#jp_container_1"
        []
        playlistOptions:
          autoPlay: true
        swfPath: './'
        solution: 'html,flash'
        supplied: 'm4a'
        preload: 'auto'
        noVolume: 
          ipad: /ipad/
          iphone: /iphone/
          ipod: /ipod/
          android_pad: /android(?!.*?mobile)/
          android_phone: /android.*?mobile/
          blackberry: /blackberry/
          windows_ce: /windows ce/
          iemobile: /iemobile/
          webos: /webos/
          playbook: /playbook/
        error: (event) ->
          console.log event
          alert 'This recording is corrupted.'
        ended: (event) ->
          console.log 'endeded'
          myPlaylist.remove myPlaylist.current - 1
          console.log myPlaylist
          $timeout ->
            if myPlaylist.playlist.length < 1
              $rootScope.initPlayer = false
              console.log '< 1'
          , 1000
          console.log $rootScope.initPlayer
    else
      myPlaylist = new jPlayerPlaylist
        jPlayer: "#jquery_jplayer_1"
        cssSelectorAncestor: "#jp_container_1"
        [{
          title:"Welcome Sing-N-Share"
          artist:"Sing-N-Share"
          m4a: 'https://d9rqh24few3wz.cloudfront.net/app/52d1b3cbcaff50fd01381e4a_C08086-C_1392288574.m4a'
          poster: ""
        }]
        playlistOptions:
          autoPlay: true
        swfPath: './'
        solution: 'flash,html'
        supplied: 'm4a'
        preload: 'auto'
        noVolume:
          ipad: /ipad/
          iphone: /iphone/
          ipod: /ipod/
          android_pad: /android(?!.*?mobile)/
          android_phone: /android.*?mobile/
          blackberry: /blackberry/
          windows_ce: /windows ce/
          iemobile: /iemobile/
          webos: /webos/
          playbook: /playbook/
        error: (event) ->
          console.log event
          alert 'This recording is corrupted.'
        ended: (event) ->
          console.log 'endeded'
          myPlaylist.remove myPlaylist.current - 1
          console.log myPlaylist
          $timeout ->
            if myPlaylist.playlist.length < 1
              $rootScope.initPlayer = false
              console.log '< 1'
          , 1000
          console.log $rootScope.initPlayer

  $scope.play = ->
    myPlaylist.play();
  
]