class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="card-deck/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    if @model.get 'revealed'
      @$el.html @template @model.attributes
    else
      @$el.html '<img src="card-deck/card-back.png">'
