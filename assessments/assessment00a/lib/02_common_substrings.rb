def common_substrings(str1, str2)
  longest_substring = ""

  start_idx = 0
  while start_idx < str1.length - 1
    len = 1
    #this basically says as long as the potential length of the substring is less than or equal to the length of string 1
    while (start_idx + len) <= str1.length
      #if the end letter is less than the length of the longest substring, make it longer so that we're always trying to find the longest substring... basically we dont want to have shit like "ens" and "ns"
      if len < longest_substring.length
        len += 1
        next
      end

      end_idx = start_idx + len
      substring = str1[start_idx..end_idx]
      #notice how we don't use an array... basically we'll have only ONE substring through this method. no need for "sort_by"
      longest_substring = substring if str2.include?(substring)

      len += 1
    end

    start_idx += 1
  end

  longest_substring
end
