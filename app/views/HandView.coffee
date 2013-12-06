class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '
    <h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %>
    (<span class="score"></span>)
    <span class="result"></span>
    </h2>
  '

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'bust', @scoreToBust, @
    @collection.on 'blackjack', @scoreToBlackjack, @
    @render()
    @collection.checkForBlackjack()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @_displayScore()

  scoreToBust: ->
    @$el.find('.result').text 'Bust'

  scoreToBlackjack: ->
    @$('.score').text @collection.scores()[1]
    @$el.find('.result').text 'Blackjack!'

  _displayScore: ->
    @$('.score').text @collection.maxScore()
