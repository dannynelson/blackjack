#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @_newGame()

  _newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # @set 'player', new Player(hand: @get('playerHand'))
    # @set 'dealer', new Player(hand: @get('dealerHand'))

    @get('playerHand').on 'all', @_playerEvent, @
    @get('dealerHand').on 'all', @_dealerEvent, @

  _playerEvent: (event) ->
    switch event
      when 'bust' then @trigger 'dealer:win', @
      when 'blackjack' then @trigger 'player:win', @
      when 'stand' then @_dealerFinishHand()

  _dealerEvent: (event) ->
    switch event
      when 'bust' then @trigger 'player:win', @
      when 'stand' then @_determineWinner()

  _dealerFinishHand: ->
    @get('dealerHand').finishHand()

  _determineWinner: ->
    if @get('dealerHand').maxScore() > @get('playerHand').maxScore()
      @trigger 'dealer:win', @
    else if @get('dealerHand').maxScore() < @get('playerHand').maxScore()
      @trigger 'player:win', @
    else
      @trigger 'push', @
