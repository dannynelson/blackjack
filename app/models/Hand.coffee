class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    # @on('add', , @)

  hit: ->
    @add(@deck.pop())
    @checkForBust()
    @last()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21 then @bust = true
    @score = if hasAce then [score, score + 10] else [score]

  checkForBust: ->
    if @scores()[0] > 21 then @trigger('bust', @)

  finishHand: ->
    @at(0).flip()
    @hit() while @scores()[0] <= 17

  stand: ->
    @trigger('stand', @)