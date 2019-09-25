// TextHandling.dm
// Contains utility procs for handling text

// dd_file2list takes two arguments (a file, and a delimiter)
// returns an array, containing the contents of the file, separated by the delimiter
/proc/dd_file2list(file_path, separator)

	var/file
	if (separator == null)
		separator = "\n"
	if (isfile(file_path))
		file = file_path
	else
		file = file( file_path )
	return dd_text2list(file2text(file), separator)
	return

// dd_replacetext takes three arguments (a string to search, a string to find, and a string to replace it with)
// returns the first argument with all instances of the second argument replaced with the third argument
/proc/dd_replacetext(text, search_string, replacement_string)

	var/textList = dd_text2list(text, search_string)
	return dd_list2text(textList, replacement_string)
	return

// same as dd_replacetext, but case sensitive
/proc/dd_replaceText(text, search_string, replacement_string)

	var/textList = dd_text2List(text, search_string)
	return dd_list2text(textList, replacement_string)
	return

// dd_hasprefix has two arguments (a string to search, and a prefix to find)
// returns 1 if the second argument is located at the beginning of the first, otherwise returns null
/proc/dd_hasprefix(text, prefix)

	var/start = 1
	var/end = length(prefix) + 1
	return findtext(text, prefix, start, end)
	return

// same as dd_hasprefix, but case sensitive
/proc/dd_hasPrefix(text, prefix)

	var/start = 1
	var/end = length(prefix) + 1
	return findText(text, prefix, start, end) // findText is being phased out; replace with findtextEx
	return

// dd_hassuffix has two arguments (a string to search, and a suffix to find)
// returns a positive value if the first argument ends with the second, otherwise returns null
/proc/dd_hassuffix(text, suffix)

	var/start = length(text) - length(suffix)
	if (start)
		return findtext(text, suffix, start, null)
	return

// same as dd_hassuffix, but case sensitive
/proc/dd_hasSuffix(text, suffix)

	var/start = length(text) - length(suffix)
	if (start)
		return findText(text, suffix, start, null) // findText is being phased out; replace with findtextEx
	return

// dd_text2list has two arguments (text, and a delimiter)
// returns a list containing the text as elements separated by the delimiter
/proc/dd_text2list(text, separator)

	var/textlength = length(text)
	var/separatorlength = length(separator)
	var/textList = new /list(  )
	var/searchPosition = 1
	var/findPosition = 1
	while(1)
		findPosition = findtext(text, separator, searchPosition, 0)
		var/buggyText = copytext(text, searchPosition, findPosition)
		textList += text("[]", buggyText)
		searchPosition = findPosition + separatorlength
		if (findPosition == 0)
			return textList
		else
			if (searchPosition > textlength)
				textList += ""
				return textList
	return

// same as dd_text2list, but case sensitive
/proc/dd_text2List(text, separator)

	var/textlength = length(text)
	var/separatorlength = length(separator)
	var/textList = new /list(  )
	var/searchPosition = 1
	var/findPosition = 1
	while(1)
		findPosition = findText(text, separator, searchPosition, 0) // findText is being phased out; replace with findtextEx
		var/buggyText = copytext(text, searchPosition, findPosition)
		textList += text("[]", buggyText)
		searchPosition = findPosition + separatorlength
		if (findPosition == 0)
			return textList
		else
			if (searchPosition > textlength)
				textList += ""
				return textList
	return

// dd_list2text has two arguments (a list, and a delimiter)
// returns text containing the elements of the list, joined by the delimiter
/proc/dd_list2text(var/list/the_list, separator)

	var/total = the_list.len
	if (total == 0)
		return
	var/newText = text("[]", the_list[1])
	var/count = 2
	while(count <= total)
		if (separator)
			newText += separator
		newText += text("[]", the_list[count])
		count++
	return newText
	return

// dd_centertext has two arguments (text, and length)
// returns the text, flanked by whitespace to center it within length
/proc/dd_centertext(message, length)

	var/new_message = message
	var/size = length(message)
	if (size == length)
		return new_message
	if (size > length)
		return copytext(new_message, 1, length + 1)
	var/delta = length - size
	if (delta == 1)
		return new_message + " "
	if (delta % 2)
		new_message = " " + new_message
		delta--
	delta = delta / 2
	var/spaces = ""
	var/count = null
	count = 1
	while(count <= delta)
		spaces += " "
		count++
	return spaces + new_message + spaces
	return

// dd_limittext has two arguments (text, and length)
// returns the text, shortened to length
/proc/dd_limittext(message, length)

	var/size = length(message)
	if (size <= length)
		return message
	else
		return copytext(message, 1, length + 1)
	return
