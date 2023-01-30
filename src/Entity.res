
module type EntityModel = {
  type t
  let id : t => string
}

module type MakeEntity = (Model: EntityModel) => {

  module type Id = {
    type t
    let make : string => t
    let toString : t => string
    type id = t //alias needed for use within Set module

    //--------------------

    module type Set = {
      type t
      let empty : t
      let add: (t, id) => t //adds element to set; if element exists in set, value is unchanged
      let remove: (t, id) => t //removes element from set; if element not in set, value is unchanged
      let toArray: t => array<id>
      let size: t => int
    }
    module Set: Set
  }
  module Id: Id

  //--------------------

  type t = {
    id: Id.t,
    model: Model.t
  }
  let make : Model.t => t
  type entity = t //alias needed for use within Map module

  //--------------------

  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t //performs `Map.set` using `entity.id` as key
    let remove: (t, Id.t) => t
    let size: t => int
    let has: (t, Id.t) => bool
  }
  module Map: Map
}

module MakeEntity: MakeEntity = (Model: EntityModel) => {

  module type Id = {
    type t
    let make : string => t
    let toString : t => string
    type id = t //alias needed for use within Set module

    module type Set = {
      type t
      let empty : t
      let add: (t, id) => t
      let remove: (t, id) => t
      let toArray: t => array<id>
      let size: t => int
    }
    module Set: Set
  }

  module Id: Id = {
    type t = string
    let make = (s: string): t => s
    let toString = (t: t): string => t
    type id = t //alias needed for use within Set module

    //--------------------

    module type Set = {
      type t
      let empty : t
      let add: (t, id) => t
      let remove: (t, id) => t
      let toArray: t => array<id>
      let size: t => int
    }

    module Set: Set = {
      type t = Belt.Set.String.t
      let empty: t = Belt.Set.String.empty
      let add = (t, id): t => t->Belt.Set.String.add(id)
      let remove = (t, id): t => t->Belt.Set.String.remove(id)
      let toArray = (t: t): array<id> => t->Belt.Set.String.toArray
      let size = (t: t): int => t->Belt.Set.String.size
    }

  }

  //--------------------

  //NB: it would be nice if there was a way to manipulate Model.t to include Id.t so everything is top level
  type t = {
    id: Id.t,
    model: Model.t
  }
  let make = (model: Model.t): t => {
    let id = model->Model.id->Id.make
    {id, model}
  }
  type entity = t //alias needed for use within Map module

  //--------------------

  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t
    let remove: (t, Id.t) => t
    let size: t => int
    let has: (t, Id.t) => bool
  }

  module Map: Map = {
    type t = Belt.Map.String.t<entity>
    let empty: t = Belt.Map.String.empty

    let get = (t: t, id: Id.t): option<entity> => {
      t->Belt.Map.String.get(id->Id.toString)
    }

    //replaces if exists
    let add = (t: t, entity: entity): t => {
      t->Belt.Map.String.set(entity.id->Id.toString, entity)
    }

    let remove = (t: t, id: Id.t): t => {
      t->Belt.Map.String.remove(id->Id.toString)
    }

    let size = (t: t): int => {
      t->Belt.Map.String.size
    }

    let has = (t: t, id: Id.t): bool => {
      t->Belt.Map.String.has(id->Id.toString)
    }
  }
}
