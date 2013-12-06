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
    it "cannot hit anymore", ->
      length = hand.length
      hand.stand()
      hand.hit()
      expect(hand.length).toEqual(length)

  describe "when player busts", ->
    it "cannot hit anymore", ->
      spyOn(hand, "scores").andReturn([22])
      hand.hit()
      length = hand.length
      hand.hit()
      expect(hand.length).toEqual(length)

  describe "finishHand", ->
    it "flips over first card", ->
      dealerHand = deck.dealDealer()
      expect(dealerHand.at(0).get('revealed')).toEqual(false)
      dealerHand.finishHand()
      expect(dealerHand.at(0).get('revealed')).toEqual(true)

    it "hits until value is 17 or greater", ->
      hand.finishHand()
      expect(hand.scores()[0]).toBeGreaterThan(16)

  describe "checkForBlackjack", ->
    it "if hand is 21 triggers 'blackjack' event", ->
      spyOn(hand, 'trigger').andCallThrough()
      spyOn(hand, "scores").andReturn([11, 21])
      hand.checkForBlackjack()
      expect(hand.trigger).toHaveBeenCalledWith('blackjack', hand)

  describe "maxScore", ->
    it "returns higher score, if higher <= 21", ->
      spyOn(hand, "scores").andReturn([9,19])
      expect(hand.maxScore()).toEqual(19)
    it "returns lower score, if higher > 21", ->
      spyOn(hand, "scores").andReturn([12,22])
      expect(hand.maxScore()).toEqual(12)
    it "returns first score if there is only one score", ->
      spyOn(hand, "scores").andReturn([19])
      expect(hand.maxScore()).toEqual(19)