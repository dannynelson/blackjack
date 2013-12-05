describe "HandView", ->
  deck = null
  hand = null
  handView = null
  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    handView = new HandView(collection: hand)

  describe 'when hand triggers "bust"', ->
    it 'it displays bust', ->
      hand.trigger('bust', hand)
      text = handView.$el.find('.result').text()
      expect(text).toEqual('Bust')

  describe 'when hand triggers "blackjack"', ->
    it 'result displays "Blackjack!"', ->
      hand.trigger('blackjack', hand)
      text = handView.$el.find('.result').text()
      expect(text).toEqual('Blackjack!')