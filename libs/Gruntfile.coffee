# jshint node: true 
module.exports = (grunt) ->
  "use strict"
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    public_path: ".."
    concat:
      scripts:
        src: ["<%= public_path %>/src/*.js"]
        dest: "<%= public_path %>/assets/js/scripts.js"

    connect:
      options: 
        port: 9020,
        hostname: 'localhost',
        livereload: 35729
      
      livereload:
        options:
          open: true
          base: "<%= public_path %>"
          
    watch:

      js:
        files: "<%= public_path %>/assets/js/*.js"
        tasks: ""

      src:
        files: "<%= public_path %>/src/*.js"
        tasks: ["uglify-scripts"]
        options:
          livereload: true

      coffee:
        files: "<%= public_path %>/coffee/*.coffee"
        tasks: ["coffee"]

      css:
        files: "<%= public_path %>/assets/css/*.css"
        options:
          livereload: true
          
      html:
        files: "<%= public_path %>/*.html"
        options:
          livereload: true

      slim:
        files: "<%= public_path %>/*.slim"
        tasks: ["slim:dev"]

      less:
        files: "<%= public_path %>/less/*.less"
        tasks: ["less", "csscomb"]

      sass:
        files: "<%= public_path %>/sass/*.{scss,sass}"
        tasks: ["sass:development", "autoprefixer"]


    uglify:
      scripts:
        src: ["<%= public_path %>/assets/js/scripts.js"]
        dest: "<%= public_path %>/assets/js/scripts.min.js"
        

    coffee:
      compile:
        options:
          join: true

        files:
          "<%= public_path %>/src/coffee.js": "<%= public_path %>/coffee/*.coffee"

    sass:
      development:
        options:
          style: 'expanded'
          loadPath: ["/Users/ceda/.rbenv/versions/2.1.4/lib/ruby/gems/2.1.0/gems/bootstrap-sass-3.3.3/assets/stylesheets/"]
        files:
          "<%= public_path %>/assets/css/style.css": "<%= public_path %>/sass/style.sass"

      production:
        options:
          style: 'compressed',
          compass: true
      
        files:
          "<%= public_path %>/assets/css/style.min.css": "<%= public_path %>/sass/style.scss"

    slim:
      dev:
        options:
          pretty: true
        files:
          "<%= public_path %>/index.html": "<%= public_path %>/index.slim"
        
    less:
      development:
        options:
          sourceMap: true
          sourceMapFilename: "<%= public_path %>/assets/css/style.css.map"
          sourceMapURL: "/assets/css/style.css.map"

        files:
          "<%= public_path %>/assets/css/style.css": "<%= public_path %>/less/style.less"

      production:
        options:
          cleancss: true
          compress: true
          ieCompat: true
          sourceMap: true
          sourceMapFilename: "<%= public_path %>/assets/css/style.min.css.map"
          sourceMapURL: "/assets/css/style.min.css.map"

        files:
          "<%= public_path %>/assets/css/style.min.css": "<%= public_path %>/less/style.less"

    autoprefixer:
      options:
        browsers: ['> 1%', 'last 2 versions','Firefox ESR','Opera 12.1']
      dist:
        files:
          "<%= public_path %>/assets/css/style.css": "<%= public_path %>/assets/css/style.css"
    
    csscomb:
      sort:
        options:
          config: "<%= public_path %>/less/.csscomb.json"

        files:
          "<%= public_path %>/assets/css/style.css": ["<%= public_path %>/assets/css/style.css"]

    csslint:
      options:
        csslintrc: "<%= public_path %>/less/.csslintrc"

      src: ["<%= public_path %>/assets/css/style.css"]

    imagemin:
      png:
        options:
          optimizationLevel: 7

        files: [
          expand: true
          cwd: "<%= public_path %>/"
          src: ["**/*.png"]
          dest: "<%= public_path %>/"
          ext: ".png"
        ]

      jpg:
        options:
          progressive: true

        files: [
          expand: true
          cwd: "<%= public_path %>/"
          src: ["**/*.jpg"]
          dest: "<%= public_path %>/"
          ext: ".jpg"
        ]

    jshint:
      options:
        globals:
          jQuery: true
          console: true
          module: true

      files: ["<%= public_path %>/assets/js/*.js", "!<%= public_path %>/assets/js/bootstrap.min.js"]

  
  # These plugins provide necessary tasks.
  require("load-grunt-tasks") grunt,
    scope: "devDependencies"
    
  grunt.registerTask "serve", (target) ->
    grunt.task.run [
      "connect:livereload"
      "watch"
    ]
    return
    

  grunt.registerTask "minify-img", ["imagemin"]
  grunt.registerTask "uglify-scripts", ["concat", "uglify"]
  grunt.registerTask "default", ["serve"]