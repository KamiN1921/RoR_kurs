#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
keys = ("a".."z").to_a
val = (1..26).to_a
alph = Hash[keys.zip(val)]

alph.delete_if{|k,v| k.match(/[aeiouy]/i).nil? }
alph.each {|k,v| puts "#{k} : #{v}" }
