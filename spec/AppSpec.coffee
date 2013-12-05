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
    it "dealer finishes hand", ->
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

  describe "When dealer finishes hand", ->
    it "determines winner(s)", ->
      dealer = app.get('dealerHand')
      dealer.finishHand()
