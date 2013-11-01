
$ ->
  fields = $('.horaries')
  fields.mask "99:99"
  fields.on 'enter', ->
    this.select()
  $('.horaries[autofocus=autofocus]').select()
