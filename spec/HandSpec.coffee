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
      hand.hit()
      expect(hand.trigger).toHaveBeenCalledWith('bust', hand)

  describe "when player stands", ->
    it "triggers stand event", ->
      spyOn(hand, 'trigger').andCallThrough()
      hand.stand()
      expect(hand.trigger).toHaveBeenCalledWith('stand', hand)

  describe "finishHand", ->
    it "flips over first card", ->
      dealerHand = deck.dealDealer()
      expect(dealerHand.at(0).get('revealed')).toEqual(false)
      dealerHand.finishHand()
      expect(dealerHand.at(0).get('revealed')).toEqual(true)

    it "hits until value is 17 or greater", ->
      hand.finishHand()
      expect(hand.scores()[0]).toBeGreaterThan(16)

