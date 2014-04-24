fs = require 'fs'
path = require 'path'

module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

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

    coffee:
      compile:
        files: [{
          expand: true
          cwd: 'examples/'
          src: [
            '**/*.coffee'
          ]
          dest: 'build/'
          ext: '.js'
        }]

    copy:
      js:
        files: [{
          expand: true
          cwd: 'examples/'
          src: [
            '**/*.js'
          ]
          dest: 'build/'
        }]
      css:
        files: [{
          expand: true
          cwd: 'examples/'
          src: [
            '**/*.css'
          ]
          dest: 'build/'
        }]
      html:
        files: [{
          expand: true
          cwd: 'examples/'
          src: [
            '**/*.html'
          ]
          dest: 'build/'
        }]
      resource:
        files: [{
          expand: true
          cwd: 'examples/'
          src: [
            '**/res/*.json'
          ]
          dest: 'build/'
          rename: (dest, src) ->
            path.normalize(path.join(dest, src.replace(/res/g, '')))
          }]

    watch:
      options:
        livereload: true
      jade:
        files: [
          'examples/**/*.jade'
          'examples/**/*.coffee'
        ]
        tasks: ['jade:compile']
      coffee:
        files: [
          'examples/**/*.coffee'
        ]
        tasks: ['coffee:compile']
      js:
        files:[
          'examples/**/*.js'
        ]
        tasks: ['copy:js']
      css:
        files:[
          'examples/**/*.css'
        ]
        tasks: ['copy:css']
      html:
        files:[
          'examples/**/*.html'
        ]
        tasks: ['copy:html']
      resource:
        files:[
          'examples/**/res/*.*'
        ]
        tasks: ['copy:resource']

    connect:
      server:
        options:
          port: 3333
          livereload: true
          base: 'build'

  grunt.registerTask 'default', [
    'clean:build'
    'compile'
    'copy'
  ]

  grunt.registerTask 'compile', [
    'jade:compile'
    'coffee:compile'
  ]

  grunt.registerTask 'static', [
    'copy:js'
    'copy:css'
    'copy:html'
    'copy:resource'
  ]

  grunt.registerTask 'live', [
    'default'
    'connect'
    'watch'
  ]
