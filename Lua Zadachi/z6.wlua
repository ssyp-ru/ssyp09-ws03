require( "iuplua" )
require( "iupluagl" )
require( "luagl" )

canvas = iup.glcanvas{buffer="DOUBLE", rastersize = "90x90"}

function canvas:resize_cb(width, height)
  iup.GLMakeCurrent(self)

  gl.Viewport(0, 0, width, height)

  gl.MatrixMode('PROJECTION')
  gl.LoadIdentity()

  gl.MatrixMode('MODELVIEW')
  gl.LoadIdentity()

end
function canvas:action()
	iup.GLMakeCurrent(self)

	gl.MatrixMode("PROJECTION")
	gl.LoadIdentity()
	gl.Ortho(0, 1, 1, 0, -1.0, 1.0)
	gl.MatrixMode("MODELVIEW")
	gl.LoadIdentity()
	gl.PushMatrix()
	gl.Translate(0.25,0.5, 0)
	gl.Scale(0.2, 0.2, 1)
	gl.BlendFunc("SRC_ALPHA", "ONE_MINUS_SRC_ALPHA")
	gl.ClearColor(0,0,0,1)
	gl.Clear("DEPTH_BUFFER_BIT,COLOR_BUFFER_BIT")
	gl.Enable("BLEND")
--основной рисунок
---------------------------1treug------------
	gl.EnableClientState ("VERTEX_ARRAY")
	vertices  = { {0,0}, {0, -1}, {-1, -1}}
	gl.VertexPointer  (vertices)
	gl.Color( {1, 1, 5, 0.5} )
	gl.Begin("TRIANGLES")
    gl.ArrayElement (0)
    gl.ArrayElement (1)
    gl.ArrayElement (2)
	gl.End()
	gl.Color( {1, 1, 5, 0.5} )
	elements = { 0, 1, 2}
	gl.DrawElements("LINE_LOOP", elements)
	---------------------------2treug---------------------
	gl.EnableClientState ("VERTEX_ARRAY")
	vertices  = { {0,0}, {0, 1}, {1, 1}}
	gl.VertexPointer  (vertices)
	gl.Color( {1, 1, 5, 0.5} )
	gl.Begin("TRIANGLES")
    gl.ArrayElement (0)
    gl.ArrayElement (1)
    gl.ArrayElement (2)
	gl.End()
	gl.Color( {1, 1, 5, 0.5} )
	elements = { 0, 1, 2}
	gl.DrawElements("LINE_LOOP", elements)
	---------------------kluv----------
	gl.EnableClientState ("VERTEX_ARRAY")
	vertices  = { {-0.5,-0.5}, {-0.5, -1}, {-1, -1}}
	gl.VertexPointer  (vertices)
	gl.Color( {1, 1, 0, 0.8} )
	gl.Begin("TRIANGLES")
    gl.ArrayElement (0)
    gl.ArrayElement (1)
    gl.ArrayElement (2)
	gl.End()
	gl.Color( {1, 1, 5, 0.5} )
	elements = { 0, 1, 2}
	gl.DrawElements("LINE_LOOP", elements)
	-----------------glaz-------------------
	gl.Begin("POLYGON")
	gl.Color( {1, 1, 0, 0.8} )
    for i=0, 100 do
      cosine = math.cos(i * 2 * math.pi/100.0)
      sine   = math.sin(i * 2 * math.pi/100.0)
      gl.Vertex(cosine-0.25,sine-0.75)
    end
	gl.End()


--основной рисунок
	iup.GLSwapBuffers(self)
	gl.Flush()

end
dialog = iup.dialog{canvas; title="Lua GL Test Application"}
dialog:show()

if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
