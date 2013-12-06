describe "App", ->
  app = null

  beforeEach ->
    app = new App()

  describe "when created", ->
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

  describe "determineWinner", ->
    describe "when player has highest score", ->
      it 'triggers player:wins', ->
        spyOn(app, 'trigger').andCallThrough()
        expect(app.trigger).toHaveBeenCalledWith('player:wins', app)
    describe 'when dealer has highest score', ->
      it 'triggers dealer:wins', ->
        spyOn(app, 'trigger').andCallThrough()
        expect(app.trigger).toHaveBeenCalledWith('dealer:wins', app)
    describe 'when player and dealer have same score', ->
      it 'triggers push' ->
        spyOn(app, 'trigger').andCallThrough()
        expect(app.trigger).toHaveBeenCalledWith('push', app)

