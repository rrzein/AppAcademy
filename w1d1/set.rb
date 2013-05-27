def set_add_el(hash, key)

  hash[key] = true
  hash
end

def set_remove_el(hash, key)
  hash.delete(key)
  hash
end

def set_list_els(hash)
  hash.keys
end

def set_member?(hash, key)
  hash.has_key?(key)
end

def set_union?(hash1, hash2)
  hash1.merge(hash2)
end

def set_intersection(hash1, hash2)
  hash1.dup.keep_if { |key, value|hash2.has_key?(key) }
  hash1
end

def set_minus(hash1, hash2)
  hash1.dup.delete_if { |key, value| hash2.include?(key) }
end

hash1 = {
  :a => 0,
  :b => 1,
  :c => 2
}

hash2 = {
  :c => 2,
  :d => 5,
  :e => 2
}

p set_add_el(hash1, :z)
p set_remove_el(hash1, :a)
p set_list_els(hash1)
p set_member?(hash1, :z)
p set_union?(hash1, hash2)
p set_intersection(hash1, hash2)
p set_minus(hash1, hash2)