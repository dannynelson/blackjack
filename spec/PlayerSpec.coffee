describe "Player", ->
  player = null
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    player = new Player(hand: hand)

  describe "when created", ->
    it "sets dealer", ->
      expect(player.get('dealer')).toBeDefined()

    it "sets hand", ->
      expect(player.get('hand').length).toEqual(2)


    it "sets winner", ->
      expect(player.get('winner')).toBeDefined()