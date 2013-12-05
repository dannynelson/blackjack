describe "Hand", ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe "When score goes above 21", ->
    it "Bust should be true", ->
      spyOn(hand, "scores").andReturn([22])
      hand.trigger('add')
      expect(hand.bust).toEqual true

  describe "When bust", ->
    it "Card cannot be added to hand", ->
      hand.bust = true
      hand.hit();
      expect(hand.length).toEqual(2);

  describe "finishHand", ->
    it "hits until value is 17 or greater", ->
      hand.finishHand()
      expect(hand.scores()[0]).toBeGreaterThan(16)
