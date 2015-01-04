@Surfaces = new Mongo.Collection 'surfaces'

if Meteor.isServer
  # Fill DB with initial values
  if Surfaces.find().count() is 0
    NUM_SURFACES = 50
    for idx in [0...NUM_SURFACES]
      Surfaces.insert
        name: "Surface #{idx + 1}"
        color: "backgroundColor: hsl(#{idx * 360 / NUM_SURFACES}, 85%, 40%)"
  # Publish collection
  Meteor.publish 'Surfaces', -> Surfaces.find()

if Meteor.isClient
  Meteor.subscribe 'Surfaces'
