class window.AppView extends Backbone.View

  className: 'app-container'

  template: _.template '
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <div>
      <button class="hit-button">Hit</button>
      <button class="stand-button">Stand</button>
    </div>
    <div class="result-box">
      <div class="final-result"></div>
      <button class="new-game">New Game</button>
    </div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game": -> @model.newGame()

  initialize: ->
    @render()
    @model.on 'all', @_displayResults, @
    @model.on 'newGame', @render, @


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$el.find('.result-box').fadeOut()

  _displayResults: (event) ->
    switch event
      when 'dealer:win' then @_displayResult 'Dealer wins!'
      when 'player:win' then @_displayResult 'You win!'
      when 'push' then @_displayResult 'Push!'

  _displayResult: (string) ->
    @$el.find('.result-box').fadeIn("slow")
    @$el.find('.final-result').text(string)
