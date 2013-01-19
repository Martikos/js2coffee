walker = undefined
fs = require("fs")
js2coffee = require("./js2coffee")
walker = require("./walk")

suffix_js = ".js"

endsWith = (str, suffix) ->
  str.indexOf(suffix, str.length - suffix.length) isnt -1

walker.walk __dirname, (error, results) ->
  if results.length > 0
    results.forEach (file_js) ->
      splits = file_js.split("/")
      name_js = splits[splits.length - 1]
      directory = file_js.split(name_js)[0]
      if endsWith(name_js, suffix_js)
        name = name_js.split(".js")[0]
        name_coffee = name + ".coffee"
        file_coffee = directory + name_coffee
        encoding = "utf-8"
        options = "-v"
        try
          contents = fs.readFileSync(file_js, encoding)
          output = js2coffee.build(contents, options)
          return fs.writeFileSync(file_coffee, output, encoding)
        catch e
          return console.log("Error Converting File: " + file_js)
