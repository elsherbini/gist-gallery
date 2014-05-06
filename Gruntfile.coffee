mountFolder = (connect, dir)->
  return connect.static(require('path').resolve(dir))


module.exports = (grunt) ->

  appConfig = {
    src: 'src'
    app: 'app'
    tmp: '.tmp'

    serverPort: 9000
    liveReloadPort: 35729
  }

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-open')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.initConfig(

    app: appConfig

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
        ]

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
        files: ['components/bootstrap/less/{bootstrap,responsive}.less']
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
