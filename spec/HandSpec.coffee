describe "Hand", ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe "If hand is dealt 21", ->
    it "triggers 'blackjack' event", ->
      spyOn(Hand.prototype, 'trigger').andCallThrough()
      spyOn(Hand.prototype, "scores").andReturn([11, 21])
      testHand = deck.dealPlayer()
      expect(testHand.trigger).toHaveBeenCalledWith('blackjack', testHand)

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

    it "triggers a finished event", ->
      dealerHand = deck.dealDealer()
      spyOn(dealerHand, 'trigger').andCallThrough()
      dealerHand.finishHand()
      expect(dealerHand.trigger).toHaveBeenCalledWith('finished', dealerHand)