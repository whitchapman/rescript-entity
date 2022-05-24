@module("uuid")
external nil: string = "NIL"

@module("uuid")
external v4: unit => string = "v4"

@module("uuid")
external validate: string => bool = "validate"

@module("uuid")
external version: string => string = "version"

@module("uuid")
external parse: string => array<int> = "parse"

@module("uuid")
external stringify: array<int> => string = "stringify"
