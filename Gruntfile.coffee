mountFolder = (connect, dir)->
  return connect.static(require('path').resolve(dir))


module.exports = (grunt) ->

  appConfig = {
    src: 'src'
    app: 'app'
    tmp: '.tmp'

    dist: 'dist'
    tmp_dist: '.tmp_dist'

    serverPort: 9000
    liveReloadPort: 35729
  }

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-open')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-usemin')

  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-htmlmin')
  grunt.loadNpmTasks('grunt-contrib-imagemin')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-requirejs')

  grunt.initConfig(

    app: appConfig

    clean:
      dist: ['<%= app.dist %>']
      tmp: ['<%= app.tmp %>']
      tmp_dist: ['<%= app.tmp_dist %>']
      components: ['<%= app.dist %>/components']
      templates: ['<%= app.dist %>/templates']

    coffee:
      dist:
        expand: true
        cwd: '<%= app.src %>/coffee/'
        src: ['{,**}/*.coffee']
        dest: '<%= app.tmp %>/js'
        ext: '.js'

    less:
      dist:
        files: [
            '<%= app.tmp %>/css/bootstrap.css' : '<%= app.app %>/components/bootstrap/less/{bootstrap,responsive}.less'
            '<%= app.tmp %>/css/main.css' : '<%= app.src %>/less/*.less'
            '<%= app.tmp %>/css/tomorrow.css': '<%= app.src %>/less/tomorrow.css'
        ]

    copy:
      dist:
        files: [{
          expand: true
          cwd: '<%= app.tmp %>/'
          src: ['**']
          dest: '<%= app.tmp_dist %>/'
        }, {
          expand: true
          cwd: '<%= app.app %>/'
          src: ['**']
          dest: '<%= app.tmp_dist %>/'
        }]

    connect:
      server:
        options:
          port: appConfig.serverPort
          hostname: '0.0.0.0'
          middleware: (connect)->
            return [
              require('connect-livereload')(port: appConfig.liveReloadPort)
              mountFolder(connect, appConfig.tmp)
              mountFolder(connect, appConfig.app)
            ]

    requirejs:
      compile:
        options:
          baseUrl: 'js/'
          appDir: './<%= app.tmp_dist %>/'
          dir: './<%= app.dist %>/'

          wrap: false

          removeCombined: true
          keepBuildDir: true

          inlineText: true
          mainConfigFile: '<%= app.tmp_dist %>/js/main.js'

          # no minification, is done by the min task
          optimize: "none"

          modules: [
            { name: 'app/vendors', exclude: [] }
            { name: 'app/app', exclude: ['app/vendors'] }
            { name: 'main', exclude: ['app/app', 'app/vendors'] }
          ]

    useminPrepare:
      html: '<%= app.tmp_dist %>/index.html'
      options:
        dest: '<%= app.dist %>'

    usemin:
      html: ['<%= app.dist %>/{,*/}*.html']
      css: ['<%= app.dist %>/css/{,*/}*.css']
      options:
        dirs: ['<%= app.dist %>']

    imagemin:
      dist:
        files: [{
          expand: true,
          cwd: '<%= app.app %>/assets'
          src: '*.{png,jpg,jpeg}'
          dest: '<%= app.dist %>/assets'
        }]

    htmlmin:
      dist:
        files: [{
          expand: true,
          cwd: '<%= app.app %>',
          src: ['*.html', 'templates/*.html'],
          dest: '<%= app.dist %>'
        }]

    uglify:
      dist:
        files: [{
          expand: true,
          cwd: '<%= app.dist %>/js',
          src: '**/*.js',
          dest: '<%= app.dist %>/js'
        }]

    open:
      server:
        path: 'http://localhost:<%= connect.server.options.port %>'

    watch:
      options:
        interrupt: true

      coffee:
        files: ['<%= app.src %>/coffee/{,**/}*.coffee']
        tasks: ['coffee:dist']

      less:
        files: ['components/bootstrap/less/{bootstrap,responsive}.less','<%= app.src %>/less/*.{less,css}']
        tasks: 'less:dist'

      files:
        files: [
          '<%= app.tmp %>/{,**/}*.{css,js}'
          '<%= app.app %>/{,**/}*.html'
        ]
        tasks: []
        options:
          livereload:
            port: appConfig.liveReloadPort

  )


  grunt.registerTask('server', [
    'coffee:dist'
    'less:dist'
    'connect:server'
    'open:server'
    'watch'
  ])


  grunt.registerTask('build', [

    'clean:dist'
    'clean:tmp'
    'clean:tmp_dist'
    'coffee:dist'
    'less:dist'
    'copy:dist'
    'requirejs:compile'
    'useminPrepare'
    'imagemin'
    'htmlmin'
    'concat'
    'usemin'
    'cssmin'
    'clean:tmp_dist'
    'clean:components'
    'clean:templates'
    'uglify'
  ])
