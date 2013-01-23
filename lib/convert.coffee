walker = undefined
fs = require("fs")
js2coffee = require("./js2coffee")
walker = require("./walk")

suffix_js = ".js"

endsWith = (str, suffix) ->
  str.indexOf(suffix, str.length - suffix.length) isnt -1

walker.recursiveCoffee __dirname, (error, results) ->
  if results.length > 0
    results.forEach (fileJs) ->
      splits = fileJs.split("/")
      nameJs = splits[splits.length - 1]
      directory = fileJs.split(nameJs)[0]
      if endsWith(nameJs, suffix_js)
        name = nameJs.split(".js")[0]
        nameCoffee = name + ".coffee"
        fileCoffee = directory + nameCoffee
        encoding = "utf-8"
        options = "-v"
        try
          contents = fs.readFileSync(fileJs, encoding)
          output = js2coffee.build(contents, options)
          return fs.writeFileSync(fileCoffee, output, encoding)
        catch e
          return console.log("Error Converting File: " + fileJs)

