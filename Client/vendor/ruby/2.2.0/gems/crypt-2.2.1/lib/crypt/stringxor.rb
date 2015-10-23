class String

  def ^(aString)
    a = self.b.unpack('C'*(self.length))
    b = aString.b.unpack('C'*(aString.length))
    if (b.length < a.length)
      (a.length - b.length).times { b << 0 }
    end
    xor = "".b()
    0.upto(a.length-1) { |pos|
      x = a[pos] ^ b[pos]
      xor << x.chr()
    }
    return(xor)
  end

end
