'use strict'

module.exports = (grunt) ->

  grunt.initConfig
    pkg : grunt.file.readJSON('package.json')

    clean :
      temp : ['./temp/']
      dist : ['./dist/']

    copy :
      temp:
        files: [(
          expand: true
          dest: 'temp/'
          cwd: 'src/'
          src: [
            'bower_components/sockjs/sockjs.js'
            'bower_components/requirejs/require.js'
            'main.js'
          ]
        )]
      dist:
        files: [(
          expand: true
          dest: 'dist/'
          cwd: 'src/'
          src: [
            'index.html'
          ]
        )]

    uglify :
      dist :
        options :
          report : 'gzip'
        files :
          'dist/scripts.min.js': [
            'temp/bower_components/sockjs/sockjs.js'
          ]

    requirejs :
      dist1 :
        options:
          baseUrl : './temp/'
          findNestedDependencies : true
          include : 'requireLib'
          logLevel : 0
          mainConfigFile : './temp/main.js'
          name : 'main'
          #optimize : 'uglify2'
          out : './dist/scripts.min.js'
          paths :
            requireLib : 'bower_components/requirejs/require'
          preserveLicenseComments : false
      dist2 :
        options:
          baseUrl : './temp/'
          findNestedDependencies : true
          include : 'requireLib'
          logLevel : 0
          mainConfigFile : './temp/main.js'
          name : 'main'
          optimize : 'uglify2'
          out : './dist/scripts.min.js'
          paths :
            requireLib : 'bower_components/requirejs/require'
          preserveLicenseComments : false

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

  grunt.registerTask 'with-uglify', ['clean', 'copy:temp', 'uglify:dist', 'copy:dist']
  grunt.registerTask 'with-rjs-min', ['clean', 'copy:temp', 'requirejs:dist2', 'copy:dist']
  grunt.registerTask 'with-rjs-nonmin', ['clean', 'copy:temp', 'requirejs:dist1', 'copy:dist']
  grunt.registerTask 'default', ['dev']
