static:
  inRuby = true

# rewrite do (x: Any):
#   puts x
# do -> String:
#   echo(x)


# rewrite do (x: Any):
#   x.to_s()
# do -> String:
#   $x
  
# rewrite do (x: String, y: String):
#   x + y
# do -> String:
#   x & y

# rewrite do (x: Int, y: Method):
#   x.times(y)
# do:
#   code:
#     forrange(args["y"].args[0], 0, args["x"], Node(kind: Code, children: args["y"].code))

# # FAITH
# rewrite do (x: Table, y: Method):
#   x.each(y)
# do:
#   code:
#     if args["y"].args.len == 1:
#       forin(args["y"].args[0], args["x"], Node(kind: Code, children: args["y"].code))
#     else:
#       forin(args["y"].args[0], args["y"].args[1], args["x"], Node(kind: Code, children: args["y"].code))
#       # TODO matching more exact , but it doesnt really matter for now
  
#   dependencies: @["tables"]

# rewrite do (x: Sequence, y: Any):
#   x.each(y)
# do:
#   code:
#     forin(args["y"].args[0], args["x"], Node(kind: Code, children: args["y"].code))

# rewrite do(x: Sequence, y: Method):
#   x.select(y)
# do:
#   code:
#     var res = send(args["x"], "filter", args["y"])
#     res.typ = args["x"].typ
#     res

# rewrite do(x: Sequence):
#   x.first()
# do:
#   code:
#     index(args["x"], 0)

# rewrite do (a: String):
#   a.downcase()
# do:
#   code:
#     send(args["a"], "lower")
#   dependencies: @["strutils"]



# rewrite do (a: Any, b: Any):
#   a.isStartWith(b)
# do:
#   a.startsWith(b)
  

# rewrite do (a: String):
#   a.upcase()
# do:
#   code:
#     send(args["a"], "upper")
#   dependencies: @["strutils"]

# rewrite do ():
#   self.private()
# do:
#   code:
#     Node(kind: Empty)

# rewrite do (a: Any):
#   a.to_a
# do:
#   code:
#     # can't type TODO
#     let typ = sequenceType(args["a"].typ)
#     send(args["a"], "toSeq")

# rewrite do (a: Any, b: Any):
#   a.isStartWith(b)
# do:
#   code:
#     send(args["a"], "startsWith", args["b"])

# rewrite do (a: Any):
#   a.is_one
# do:
#   code:
#     let c = call(variable("len"), args["a"], IntType)
#     compare(operator("=="), c, 1, BoolType)

