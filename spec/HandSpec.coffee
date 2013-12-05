describe "Hand", ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe "When score goes above 21", ->
    it "triggers bust event", ->
      spyOn(hand, "scores").andReturn([22])
      spyOn(hand, 'trigger').andCallThrough()

      hand.trigger('add')
      expect(hand.trigger).toHaveBeenCalledWith('bust', hand)

  # xdescribe "When bust", ->
  #   it "Card cannot be added to hand", ->
  #     hand.bust = true
  #     hand.hit();
  #     expect(hand.length).toEqual(2);

  describe "when player stands", ->
    it "triggers stand event", ->
      spyOn(hand, 'trigger').andCallThrough()
      hand.stand()
      expect(hand.trigger).toHaveBeenCalledWith('stand', hand)

  # xdescribe "finishHand", ->
  #   it "hits until value is 17 or greater", ->
  #     hand.finishHand()
  #     expect(hand.scores()[0]).toBeGreaterThan(16)
