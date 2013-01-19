fs = require("fs")

walk = (dir, done) ->
  results = undefined
  results = []
  fs.readdir dir, (err, list) ->
    pending = undefined
    return done(err)  if err
    pending = list.length
    return done(null, results)  unless pending
    list.forEach (file) ->
      file = dir + "/" + file
      fs.stat file, (err, stat) ->
        if stat and stat.isDirectory()
          walk file, (err, res) ->
            results = results.concat(res)
            done null, results  unless --pending

        else
          results.push file
          done null, results  unless --pending

exports.walk = walk
