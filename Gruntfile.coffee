fs = require 'fs'
path = require 'path'

module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.initConfig
    clean:
      build: ['build']

    jade:
      compile:
        options:
          pretty: true
          data: (dest, src) ->
            require './' + path.dirname(src) + '/locals.json'
        files: [{
          expand: true
          cwd: 'examples/'
          src: [
            '**/*.jade'
          ]
          dest: 'build/'
          ext: '.html'
        }]

    copy:
      build:
        files: [{
          expand: true
          cwd: 'examples/'
          src: [
            '**/*.css'
            '**/*.js'
            '**/*.html'
          ]
          dest: 'build/'
        }]

    watch:
      options:
        livereload: true
      templates:
        files: ['examples/**/*.jade']
        tasks: ['jade:compile']
      static:
        files:[
          'examples/**/*.js'
          'examples/**/*.css'
          'examples/**/*.html'
        ]
        tasks: ['copy:build']

    connect:
      server:
        options:
          port: 3333
          livereload: true
          base: 'build'

  grunt.registerTask 'default', [
    'clean:build'
    'jade:compile'
    'copy:build'
  ]

  grunt.registerTask 'live', [
    'default'
    'connect'
    'watch'
  ]