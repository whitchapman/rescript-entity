open Belt

module type EntityData = {
  type t
  let id : t => string
}

module type MakeEntity = (Data: EntityData) => {

  module type Id = {
    type t
    let make : string => t
    let toString : t => string
  }
  module Id: Id

  type t = {
    id: Id.t,
    data: Data.t
  }
  let make : Data.t => t
  type entity = t //alias needed for use within Map module

  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t //performs `Map.set` using `entity.id` as key
  }
  module Map: Map
}

module MakeEntity: MakeEntity = (Data: EntityData) => {

  module type Id = {
    type t
    let make : string => t
    let toString : t => string
  }

  module Id = {
    type t = string
    let make = s => s
    let toString = t => t
  }

  //NB: it would be nice if there was a way to manipulate Data.t to include Id.t so everything is top level
  type t = {
    id: Id.t,
    data: Data.t
  }
  let make = (data: Data.t): t => {
    let id = data->Data.id->Id.make
    {id, data}
  }
  type entity = t //alias needed for use within Map module


  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t
  }

  module Map = {
    type t = Map.String.t<entity>
    let empty = Map.String.empty

    let get = (t: t, id: Id.t) => {
      t->Map.String.get(id)
    }

    //replaces if exists
    let add = (t: t, entity: entity) => {
      t->Map.String.set(entity.id, entity)
    }
  }
}
