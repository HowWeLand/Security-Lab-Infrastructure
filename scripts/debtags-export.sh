#!/bin/sh
# This is a WiP progress to pull the debtags package tagging from 
# Kali package repos and prep it for ingestion and creation of a database
# for my own pruposes.  I don't plan on making this a broader project and 
# only ever guarantee it works on my machines.
# However because it is a relatively harmless project, it makes a good
# way to explain some concepts that rarely get discussid in plain english
# "You must suffer for your knowledge" being the order of the day
# I think, "F that." Let me give you a hand on how I (emphasis here)
# interpet how to git r' done.  If this helps you, great! If it doesn't work,
# and you can explain why without sounding like a jerk, great!  If you have a
# quick question, and aren't waiting on a timely answer, I can help you.
# Otherwise I guarantee nothing.  To mangle a Jello Biafra bit
# If it sounds sarcastic, don't take it so seriously.
# If this looks dangerous, do not try this on your system or at all.
# If it offends you, just don't use it.


# Cause nothing says modular and reuasble like a variable declaration
OUTPUT_FILE="all-deb-tags.txt"	# Make this whatever works for you

# Yanked and copied this to an if  statement.
# Then i realized perfect chance to demonstrate modularizing functions
test_output_file_success() {
	# Test to make sure file appears.  This is a simpler way to make an if statement
	# In fact it's safer but it does not work if strict POSIX complainece
	# is what you're after
	# https://en.wikipedia.org/wiki/POSIX
	# Also even though [[ ]] does support the quote free version,
	# I want it to only look for OUTPUT_FILE and not think for itself
	[[ -f "$OUTPUT_FILE" ]] && \ # Use this if you think you're going to
		# go over ~80 characters
		echo "Fresh $OUTPUT_FILE created" # You can comment on the end
		#of lines but be aware of line limits
}


# Let us make a clean copy here and remove the apostraphe because shell
# will not shut up about it
make_clean_file(){
	# If statement here checks for presence of OUTPUT_FILE
	if [ -f "$OUTPUT_FILE" ]; then {
		# If it's found we inform the user that we are removing
		echo "Found $OUTPUT_FILE. Removing..."
		# We remove it, with output from rm
		rm -rfv "$OUTPUT_FILE"
		# We tell the user We are making a new one
		echo "Making fresh $OUTPUT_FILE"
		# Touch normally just updates access times but
		# will also create a file that wasn't there
		touch "$OUTPUT_FILE"
		# Show the user it exists
		ls -l "$OUTPUT_FILE"
		# Test to make sure the file appears.
		test_output_file_success
	};
	# On the other hand if it doesn't exist already
	else {
		# Tell the user it wasn't found
		echo "No $OUTPUT_FILE found. Making..."
		# That we'll make a new one
		echo "Making fresh $OUTPUT_FILE"
		# Like earlier, we make a new one
		touch "$OUTPUT_FILE"
		# Show the user what we did
		ls -l "$OUTPUT_FILE"
		# Testing belongs here too
		test_output_file_success
		echo "Fresh $OUTPUT_FILE created"
	};
    fi
}

# Would believe in my first draft I forgot to actually run the code
make_clean_file
