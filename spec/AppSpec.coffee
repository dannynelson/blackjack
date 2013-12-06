describe "App", ->
  app = null

  beforeEach ->
    app = new App()

  xdescribe "when created", ->
    it "creates a dealer player", ->
      expect(app.get('dealer')).toEqual(jasmine.any(Player));
    it "creates a dealer player", ->
      expect(app.get('player')).toEqual(jasmine.any(Player));

  describe "When player busts", ->
    xit "dealer finishes hand", ->
      dealer = app.get('dealerHand')
      spyOn(dealer, 'finishHand')
      app.get('playerHand').trigger('bust')
      expect(dealer.finishHand).toHaveBeenCalled()

  describe "When player stands", ->
    it "dealer finishes hand", ->
      dealer = app.get('dealerHand')
      spyOn(dealer, 'finishHand')
      app.get('playerHand').trigger('stand')
      expect(dealer.finishHand).toHaveBeenCalled()

  describe "When player triggers blackjack", ->
    it "triggers player:win", ->
      player = app.get('playerHand')
      spyOn(app, 'trigger').andCallThrough()
      app.get('playerHand').trigger('blackjack')
      expect(app.trigger).toHaveBeenCalledWith('player:win', app)

  describe "determineWinner", ->
    describe "when player has highest score", ->
      it 'triggers player:win', ->
        spyOn(app.get('playerHand'), 'maxScore').andReturn(20)
        spyOn(app.get('dealerHand'), 'maxScore').andReturn(18)
        spyOn(app, 'trigger').andCallThrough()
        app._determineWinner()
        expect(app.trigger).toHaveBeenCalledWith('player:win', app)

    describe 'when dealer has highest score', ->
      it 'triggers dealer:win', ->
        spyOn(app.get('playerHand'), 'maxScore').andReturn(18)
        spyOn(app.get('dealerHand'), 'maxScore').andReturn(20)
        spyOn(app, 'trigger').andCallThrough()
        app._determineWinner()
        expect(app.trigger).toHaveBeenCalledWith('dealer:win', app)

    describe 'when player and dealer have same score', ->
      it 'triggers push', ->
        spyOn(app.get('playerHand'), 'maxScore').andReturn(18)
        spyOn(app.get('dealerHand'), 'maxScore').andReturn(18)
        spyOn(app, 'trigger').andCallThrough()
        app._determineWinner()
        expect(app.trigger).toHaveBeenCalledWith('push', app)

  describe "newGame", ->
    it "starts a new game", ->
      app.get('playerHand').hit()
      lenBefore = app.get('playerHand').length
      app._newGame()
      lenAfter = app.get('playerHand').length
      expect(lenBefore).not.toEqual(lenAfter)