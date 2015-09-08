# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

##################################
# Useful functions
randomNum = (max,min=0) ->
    return Math.floor(Math.random() * (max - min) + min)

rainbow = (numOfSteps, step) ->
  # This function generates vibrant, "evenly spaced" colours (i.e. no clustering). This is ideal for creating easily distiguishable vibrant markers in Google Maps and other apps.
  # HSV to RBG adapted from: http://mjijackson.com/2008/02/rgb-to-hsl-and-rgb-to-hsv-color-model-conversion-algorithms-in-javascript
  # Adam Cole, 2011-Sept-14
  r = undefined
  g = undefined
  b = undefined
  h = step / numOfSteps
  i = ~ ~(h * 6)
  f = h * 6 - i
  q = 1 - f
  switch i % 6
    when 0
      r = 1
      g = f
      b = 0
    when 1
      r = q
      g = 1
      b = 0
    when 2
      r = 0
      g = 1
      b = f
    when 3
      r = 0
      g = q
      b = 1
    when 4
      r = f
      g = 0
      b = 1
    when 5
      r = 1
      g = 0
      b = q
  c = '#' + ('00' + (~ ~(r * 255)).toString(16)).slice(-2) + ('00' + (~ ~(g * 255)).toString(16)).slice(-2) + ('00' + (~ ~(b * 255)).toString(16)).slice(-2)
  c

##################################
# Constants
CAN_WIDTH = CAN_HEIGHT = 300
CAN_COLOR = "#ccc"
LINE_WIDTH = 2

##################################
# Global vars

line_x = 0
line_y = CAN_HEIGHT/2

gv_context = undefined
##################################

create_canvas = ->
  gv_canvas = document.createElement('canvas')
  gv_canvas.width = CAN_WIDTH
  gv_canvas.height = CAN_HEIGHT
  gv_context = gv_canvas.getContext('2d')
  $("#container").append(gv_canvas)
  # gv_context.fillRect 0, 0, CAN_WIDTH, CAN_HEIGHT

timer_animation = (callback) ->
  console.log(callback)
  window.setTimeout callback, 3000 / 60

anim = ->
  if line_x > CAN_WIDTH
    line_x = 0

  if line_x == 0
    # Clearing canvas
    gv_context.fillStyle = CAN_COLOR
    gv_context.fillRect(0, 0, CAN_WIDTH, CAN_HEIGHT)

  old_line_x = line_x
  old_line_y = line_y

  # Coordinates for next part of line
  line_y = randomNum(CAN_HEIGHT*(2/3), CAN_HEIGHT/3)
  line_x += randomNum(10, 1)

  gv_context.beginPath()
  gv_context.lineWidth = LINE_WIDTH
  gv_context.strokeStyle = rainbow(CAN_WIDTH, old_line_x)
  gv_context.moveTo old_line_x, old_line_y
  gv_context.lineTo line_x, line_y
  gv_context.stroke()

drawing_cycle = ->
  anim()
  timer_animation(drawing_cycle)

$ ->
  create_canvas()
  drawing_cycle()
