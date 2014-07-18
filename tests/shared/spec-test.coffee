Test.run 'Spec (class)',
  tearDown: -> BDD.reset()
  tests:
    'is an instance of [Method]': (test) ->
      spec = new BDD.Spec('does something', ->)
      expect(spec).to.be.an.instanceOf BDD.Method


    'has a name (description)': (test) ->
      fn = ->
      method = new BDD.Spec('does something', fn)
      expect(method.name).to.equal 'does something'
      expect(method.func).to.equal fn


    'has a unique ID as a hash of the name/description': (test) ->
      spec = new BDD.Spec('does something', ->)
      expect(spec.id).to.equal Util.hash('does something')

