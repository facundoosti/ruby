require 'bundler'
Bundler.require

helpers do
	def form method, action, &block
		'<form method="post" action='+action[:action]+'>'+ yield(block)+'</form>'
	end
	
	def input type, name
		'<input type='+type+' name="_method" value='+name+'>'
	end
end

get '/' do
	erb :index 
end
