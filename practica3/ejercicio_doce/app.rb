require 'bundler'
Bundler.require

helpers do
	def form method, action, &block
		metodo = method.scan(/\w+/).last
		accion = action.scan(/\S+/).last
		'<form method="post" action='+accion+'><input type="hiden" name="_method" value="'+metodo+'"/></form>'+ yield(block)
	end
	
	def submit name
		'<input type="submit" value='+name+'>'
	end
end

get '/' do
	erb :index 
end
