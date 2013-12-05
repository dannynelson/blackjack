class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'bust', @scoreToBust, @
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    debugger
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  scoreToBust: ->
    debugger
    setTimeout(=> @$el.find('.score').text 'Bust', 0)
