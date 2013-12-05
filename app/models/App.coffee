#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @set 'player', new Player(hand: @get('playerHand'))
    @set 'dealer', new Player(hand: @get('dealerHand'))

    @get('playerHand').on 'bust stand', @_dealerFinishHand, @

  _dealerFinishHand: ->
    @get('dealerHand').finishHand()

  _determineWinner: ->