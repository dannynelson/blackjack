class window.Hand extends Backbone.Collection

  model: Card

  playable: true

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @playable
      @add(@deck.pop())
      @checkForBust()
      @last()

  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21 then @bust = true
    @score = if hasAce then [score, score + 10] else [score]

  checkForBust: ->
    if @scores()[0] > 21
      @playable = false
      @trigger('bust', @)

  checkForBlackjack: ->
    if @scores()[1] is 21 then @trigger('blackjack', @)

  finishHand: ->
    @at(0).flip()
    @hit() while @scores()[0] <= 17
    if @maxScore() > 21
      @trigger 'bust', @
    else
      @trigger 'stand', @

  stand: ->
    @playable = false
    @trigger 'stand', @

  maxScore: ->
    score = @scores()
    if score[1] < 21 then score[1] else score[0]

