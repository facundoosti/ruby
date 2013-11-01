require "bundler"
Bundler.require

repo = Octokit.repo 'TTPS-ruby/capacitacion-ruby-ttps'
repo.rels[:contributors].get.data.each {|user| p user.login + "("+user.contributions.to_s+")"}
