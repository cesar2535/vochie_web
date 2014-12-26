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
var sourcemaps         = require('gulp-sourcemaps');
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
  gutil.log(gutil.colors.yellow(err.message));
  browserSync.notify(err.message, 5000);
  notify.onError({
    title: 'Gulp',
    message: "Error: <%= error.message %>",
    sound: 'Pop'
  }) (err);
};

gulp.task('clear', function() {
  del.sync(['build/**/*.html', 'build/**/*.js', 'build/**/*.css']);
});

// CoffeeScript
gulp.task('coffee', function() {
  return gulp.src(srcFiles.coffee)
    .pipe(plumber({ errorHandler: errorHandler }))
    .pipe(changed(buildDir.scripts, { extension: '.js'}))
    .pipe(sourcemaps.init())
    .pipe(coffee({ bare: true }))
    .pipe(concat('app.js'))
    .pipe(rename({ suffix: '.min' }))
    .pipe(uglify({ compress: true }))
    .pipe(sourcemaps.write({
      addComment: true,
      sourceRoot: '/src'
    }))
    .pipe(gulp.dest(buildDir.scripts));
});

// Compass
gulp.task('compass', function() {
  var stream = gulp.src(srcFiles.sass)
  .pipe(compass({
    sourcemap: true,
    css: 'build/stylesheets',
    sass: 'src/sass',
    require: ['susy']
  }))
  .on('error', function (err) {
    gutil.log(gutil.colors.yellow(err.message));
    browserSync.notify(err.message, 5000);
    stream.end()
  })
  .pipe(gulp.dest(buildDir.style))
  .pipe(reload({ stream: true }));
  return stream;
});

// Jade
gulp.task('jade', function() {
  return gulp.src([srcFiles.main, srcFiles.views], { base: 'src'})
    .pipe(plumber({ errorHandler: errorHandler}))
    .pipe(changed(buildDir.main, { extension: '.html' }))
    .pipe(jade({ pretty: true }))
    .pipe(gulp.dest(buildDir.main));
});

// Library
gulp.task('lib', function() {
  return gulp.src(srcFiles.assets, { base: 'src/assets'})
    .pipe(gulp.dest(buildDir.main));
});

// Server
gulp.task('server',['build'], function() {
  browserSync({
    server: {
      baseDir: 'build'
    },
    port: 8080,
  });
});

// Livereload
gulp.task('livereload',['server'], function() {
  var watchFiles = ['build/**/*.html', 'build/**/*.js', 'build/**/*.css'];
  gulp.watch(srcFiles.main, ['jade']);
  gulp.watch(srcFiles.views, ['jade']);
  gulp.watch(srcFiles.coffee, ['coffee']);
  gulp.watch(srcFiles.sass, ['compass']);
  gulp.watch(srcFiles.assets, ['lib']);
  gulp.watch(watchFiles, function (file) {
    if (file.type === 'changed')
      return reload(file.path);
  });
});

gulp.task('publish',['build'], function() {
  return gulp.src('build/**', { base: 'build' })
    .pipe(gulp.dest('_public'));
});

gulp.task('compile', ['coffee', 'compass', 'jade']);
gulp.task('build', ['compile', 'lib']);
gulp.task('default', ['build', 'livereload']);