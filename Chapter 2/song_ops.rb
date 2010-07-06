module SongOps

    # Note the = 'some string' is a default parameter.
    # This means that string will contain 'some string' if no value is passed in.
	def SongOps.capitalize(string = 'some string')
		puts string.capitalize
	end

end
