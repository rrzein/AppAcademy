def subsets(arr)
  if arr.empty?
    [[]]
  else
    #take the first item in the subset
    val = arr[0]
    #then take the next item in the subset
    subs = subsets(arr[1..-1])
    #take the first item of the subset, then merge it with the next item of the subset
    new_subs = subs.map { |sub| [val] + sub }
    #take the original no_item subset, then put it in an array together with an array of that original item plus its merging with the next item
    subs + new_subs
    #and so on.
  end
end