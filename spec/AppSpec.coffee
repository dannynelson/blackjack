describe "App", ->
  app = null

  beforeEach ->
    app = new App()

  describe "When player busts", ->
    it "dealer finishes hand", ->
      debugger


      dealer = app.get('dealerHand')
      spyOn(dealer, 'finishHand')
      app.get('playerHand').trigger('bust')
      
      expect(dealer.finishHand).toHaveBeenCalled()