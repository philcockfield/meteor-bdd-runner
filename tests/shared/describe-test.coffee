describe 'describe', ->
  afterEach -> BDD.reset()

  it 'does not fail if not function is specified', ->
    BDD.describe 'foo'


  it 'adds a suite to the root', ->
    BDD.describe 'my thing', ->
    children = BDD.suite.children
    expect(children.length).to.equal 1
    expect(children[0].name).to.equal 'my thing'


  it 'resets the root suite', ->
    BDD.describe 'my thing', ->
    expect(BDD.suite.children.length).to.equal 1
    BDD.reset()
    expect(BDD.suite.children.length).to.equal 0



  it 'adds a nested suite', ->
    result = BDD.describe 'parent', ->
               BDD.describe 'child1', ->
               BDD.describe 'child2', ->
                BDD.describe 'grandchild1', ->

    parent = BDD.suite.children[0]
    child1 = parent.children[0]
    child2 = parent.children[1]
    grandchild1 = child2.children[0]

    expect(child1.name).to.equal 'child1'
    expect(child1.parent).to.equal parent
    expect(child1.children.length).to.equal 0

    expect(child2.name).to.equal 'child2'
    expect(child2.parent).to.equal parent
    expect(child2.children.length).to.equal 1

    expect(grandchild1.name).to.equal 'grandchild1'
    expect(grandchild1.parent).to.equal child2
    expect(grandchild1.children.length).to.equal 0

    expect(BDD.suite.children.length).to.equal 1
    expect(parent.children.length).to.equal 2
