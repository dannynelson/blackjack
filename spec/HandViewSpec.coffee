describe "HandView", ->
  deck = null
  hand = null
  handView = null
  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    handView = new HandView(collection: hand)

  xdescribe 'when hand triggers "bust"', ->
    it 'it displays bust', ->
      hand.trigger('bust', hand)
      text = handView.$el.find('.score').text()
      expect(text).toEqual('Bust')