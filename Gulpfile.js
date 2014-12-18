var gulp               = require('gulp');
var browserSync        = require('browser-sync');
var historyApiFallback = require('connect-history-api-fallback');
var del                = require('del');
var reload             = browserSync.reload;

var changed            = require('gulp-changed');
var coffee             = require('gulp-coffee');
var compass            = require('gulp-compass');
var concat             = require('gulp-concat');
var jade               = require('gulp-jade');
var notify             = require('gulp-notify');
var plumber            = require('gulp-plumber');
var rename             = require('gulp-rename');
var uglify             = require('gulp-uglify');
var gutil              = require('gulp-util');

var srcFiles = {
  main: 'src/index.jade',
  views: 'src/views/**/*.jade',
  coffee: 'src/coffee/**/*.coffee',
  sass: 'src/sass/**/*.sass',
  assets: 'src/assets/**'
};

var buildDir = {
  main: 'build',
  views: 'build/views',
  style: 'build/stylesheets',
  scripts: 'build/scripts'
};

var errorHandler = function (err) {
  notify.onError({
    title: 'Gulp',
    message: "Error: <%= err.message %>",
    sound: 'Pop'
  }) (err);
};

gulp.task('clear', function() {
  del.sync(['build/**/*.html', 'build/**/*.js', 'build/**/*.css']);
});

gulp.task('default', ['build', 'server']);