class String 
  def offset int
    (self[-1,1].ord()+int).chr
  end
  def mirror
    rownum= "h".ord-((self[-1,1].ord())-("a".ord))
    rownum.chr
  end
end
