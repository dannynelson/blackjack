#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'bust', @_dealerFinishHand, @
    @get('playerHand').on 'stand', @_dealerFinishHand, @

  _dealerFinishHand: ->
    @get('dealerHand').finishHand()