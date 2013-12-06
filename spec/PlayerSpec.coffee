describe "Player", ->
  player = null
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    player = new Player(hand: hand)

  xdescribe "when created", ->
    it "sets dealer", ->
      expect(player.get('dealer')).toBeDefined()

    it "sets hand", ->
      expect(player.get('hand').length).toEqual(2)

    it "sets scores to [0]", ->
      expect(player.get('scores')).toEqual([0])

    it "sets winner", ->
      expect(player.get('winner')).toBeDefined()

    it "sets a name", ->
      expect(player.get('name')).toEqual('Player')

  xdescribe "when player receives card", ->
    it "updates the player scores", ->
      spyOn(hand, 'scores').andReturn([14])
      player = new Player(hand: hand)
      player.get('hand').hit()
      expect(player.get('scores')).toEqual([14])


