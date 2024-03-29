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

  describe 'when hand includes an ace', ->
    it 'displays both hand scores', ->
      spyOn(hand, 'scores').andReturn([4,14])
      handView.render()
      result = handView.$el.find('.score').text()
      expect(result).toEqual('14')

    describe 'when higher score is above 21', ->
      it 'only displays the lower score', ->
        spyOn(hand, 'scores').andReturn([14,24])
        handView.render()
        result = handView.$el.find('.score').text()
        expect(result).toEqual('14')