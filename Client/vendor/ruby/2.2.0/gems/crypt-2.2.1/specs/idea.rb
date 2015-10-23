require 'crypt/idea'
require 'fileutils'

describe "Crypt::IDEA" do

	it "encrypts and decrypts 4-byte pairs" do
		enc = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::ENCRYPT)
		dec = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::DECRYPT)
		origL = 0x385a41f2 
		origR = 0xe03e5930
		cl, cr = enc.crypt_pair(origL, origR)
		dl, dr = dec.crypt_pair(cl, cr)
		expect(dl).to eql(origL)
		expect(dr).to eql(origR)
	end

	it "encrypts and decrypts 8-byte blocks" do
		enc = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::ENCRYPT)
		dec = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::DECRYPT)
    block = "norandom"
    encryptedBlock = enc.encrypt_block(block)
    expect(encryptedBlock).to eql("\xC2lzEU\x81\e_".b())
    decryptedBlock = dec.decrypt_block(encryptedBlock)
    expect(decryptedBlock).to eql(block)
	end
	
	it "encrypts and decrypts strings" do
    enc = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::ENCRYPT)
		dec = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::DECRYPT)
    string = "This is a string which is not a multiple of 8 characters long"
    encryptedString = enc.encrypt_string(string)
    decryptedString = dec.decrypt_string(encryptedString)
    expect(decryptedString).to eql(string)
	end
	
	it "encrypts and decrypts a file" do
		plainText = "This is a multi-line string\nwhich is not a multiple of 8 \ncharacters long."
    plainFile = File.new('plain.txt', 'wb+')
    plainFile.puts(plainText)
    plainFile.close()
    enc = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::ENCRYPT)
		dec = Crypt::IDEA.new("Nothing can stop an idea whose time has come", Crypt::IDEA::DECRYPT)
    enc.encrypt_file('plain.txt', 'crypt.txt')
    dec.decrypt_file('crypt.txt', 'decrypt.txt')
    decryptFile = File.new('decrypt.txt', 'rb')
    decryptText = decryptFile.readlines().join('').chomp()
    decryptFile.close()
    expect(decryptText).to eql(plainText)
    FileUtils.rm('plain.txt')
    FileUtils.rm('crypt.txt')
    FileUtils.rm('decrypt.txt')
	end
	
	def h(s)
		[s].pack("H*")
	end
	
	def n8(s)
		h(s).unpack("n8")
	end
	
	def conform(key, plain, cipher)
		enc = Crypt::IDEA.new("", Crypt::IDEA::ENCRYPT)
		enc.subkeys = enc.generate_encryption_subkeys(key)
		dec = Crypt::IDEA.new("", Crypt::IDEA::ENCRYPT)
		dec.subkeys = dec.generate_decryption_subkeys(key)
		encryptedBlock = enc.encrypt_block(plain)
    expect(encryptedBlock).to eql(cipher.b())
		decryptedBlock = dec.decrypt_block(encryptedBlock)
    expect(decryptedBlock).to eql(plain)
	end
		
	def conform_dec(key, cipher, plain)
		dec = Crypt::IDEA.new("", Crypt::IDEA::ENCRYPT)
		dec.subkeys = dec.generate_decryption_subkeys(key)
		decryptedBlock = dec.decrypt_block(cipher)
    expect(decryptedBlock).to eql(plain)
	end
		
	it "conforms to enceryption test vectors" do
		conform([0x8000,0,0,0,0,0,0,0], h("0000000000000000"), h("B1F5F7F87901370F"))
		conform([0x4000,0,0,0,0,0,0,0], h("0000000000000000"), h("B3927DFFB6358626"))
		conform([0x2000,0,0,0,0,0,0,0], h("0000000000000000"), h("E987E0029FB99785"))
		conform([0x1000,0,0,0,0,0,0,0], h("0000000000000000"), h("754A03CE08DB7DAA"))
		conform([0x0800,0,0,0,0,0,0,0], h("0000000000000000"), h("F015F9FB0CFC7E1C"))
		conform([0x0400,0,0,0,0,0,0,0], h("0000000000000000"), h("69C9FE6007B8FCDF"))
		conform([0x0200,0,0,0,0,0,0,0], h("0000000000000000"), h("8DA7BC0E63B40DD0"))
		conform([0x0100,0,0,0,0,0,0,0], h("0000000000000000"), h("2C49BF7DE28C666B"))
		conform([  0x80,0,0,0,0,0,0,0], h("0000000000000000"), h("9A4717E8F935712B"))
		conform([0,0x8000,0,0,0,0,0,0], h("0000000000000000"), h("95A96731978C1B9A"))
		conform([0,0,0x8000,0,0,0,0,0], h("0000000000000000"), h("398BD9A59E9F5DDB"))
		conform([0,0,0,0x8000,0,0,0,0], h("0000000000000000"), h("AC1D8708AF0A37EE"))
		conform([0,0,0,0,0x8000,0,0,0], h("0000000000000000"), h("FAE3FA7B8DB08800"))
		conform([0,0,0,0,0,0x8000,0,0], h("0000000000000000"), h("B5803F82C0633F01"))
		conform([0,0,0,0,0,  0x10,0,0], h("0000000000000000"), h("9E25090B7D4EF24E"))
		conform([0,0,0,0,0,   0x8,0,0], h("0000000000000000"), h("EF62C1109F374AA8"))
		conform([0,0,0,0,0,   0x2,0,0], h("0000000000000000"), h("5F0CCFE5EB0F19A8"))
		conform([0xffff,0xffff,0xffff,0xffff,0xffff,0x1,0x000f,0xffff], h("0000000000000000"), h("2E4329C12455430B"))
		# had problems with bits 95 to 108 inclusive, fixed by final % USHORT on mul()
		conform([0,0,0,0,0,   0x1,0,0], h("0000000000000000"), h("FCC40014010D617C"))
		conform([0,0,0,0,0,0,0x8000,0], h("0000000000000000"), h("705D780834A498DA"))
		conform([0,0,0,0,0,0,0x4000,0], h("0000000000000000"), h("9BCA7BF025B38A68"))
		conform([0,0,0,0,0,0,0x2000,0], h("0000000000000000"), h("5CF67D0181CB01C1"))
		conform([0,0,0,0,0,0,0x1000,0], h("0000000000000000"), h("ECDE3D81820381C1"))
		conform([0,0,0,0,0,0,  0x80,0], h("0000000000000000"), h("C781050DC4110220"))
		conform([0,0,0,0,0,0,  0x40,0], h("0000000000000000"), h("6DFD0287EC4C0110"))
		conform([0,0,0,0,0,0,  0x20,0], h("0000000000000000"), h("3B8A017EFB61800E"))
		conform([0,0,0,0,0,0,  0x10,0], h("0000000000000000"), h("A08F7F81FF627FC0"))
		conform([0,0,0,0,0,0,   0x8,0], h("0000000000000000"), h("00503FC1AFB93FE0"))
		conform([0,0,0,0,0,0,   0x1,0], h("0000000000000000"), h("46D371477F33B152"))
		conform([0,0,0,0,0,0,0,0x8000], h("0000000000000000"), h("BE67AC7DA294CA7C"))
		conform([0,0,0,0,0,0,0,0], h("8000000000000000"), h("8001000180008000"))
		conform([0,0,0,0,0,0,0,0], h("0080000000000000"), h("9181E3014C80C980"))
		conform([0,0,0,0,0,0,0,0], h("0000800000000000"), h("0001800180008000"))
		conform([0,0,0,0,0,0,0,0], h("0000000200000000"), h("FF49003BFF26FFAA"))
		conform([0,0,0,0,0,0,0,0], h("0000000004000000"), h("100100014C00E000"))
		conform([0,0,0,0,0,0,0,0], h("0000000000040000"), h("01110001FE4C00E0"))
		conform([0,0,0,0,0,0,0,0], h("0000000000001000"), h("8001C001E0009000"))
		conform([0,0,0,0,0,0,0,0], h("0000000000000100"), h("C8012C018E009900"))
		conform([0,0,0,0,0,0,0,0], h("0000000000000040"), h("32010B012380E640"))
		conform([0x0101,0x0101,0x0101,0x0101,0x0101,0x0101,0x0101,0x0101], h("0101010101010101"), h("E3F8AFF7A3795615"))
		conform([0x7777,0x7777,0x7777,0x7777,0x7777,0x7777,0x7777,0x7777], h("7777777777777777"), h("D2E486D93304B9B6"))
		conform([0xF7F7,0xF7F7,0xF7F7,0xF7F7,0xF7F7,0xF7F7,0xF7F7,0xF7F7], h("F7F7F7F7F7F7F7F7"), h("8E13C368F53E55AF"))
		conform([1,0x203,0x405,0x607,0x809,0xa0b,0xc0d,0xe0f], h("0011223344556677"), h("F526AB9A62C0D258"))
	end
	
	it "conforms to decryption test vectors" do
		conform_dec(n8("80000000000000000000000000000000"), h("0000000000000000"), h("78071EE87F0130E8"))
		conform_dec(n8("00008000000000000000000000000000"), h("0000000000000000"), h("14D47C44835EEB99"))
		conform_dec(n8("00000000800000000000000000000000"), h("0000000000000000"), h("CEA444C8CE44C2C2"))
		conform_dec(n8("00000000000000000080000000000000"), h("0000000000000000"), h("6A9EF2F77DE21D8E"))
		conform_dec(n8("00000000000000000000000800000000"), h("0000000000000000"), h("E698BE39AEA13C79"))
		conform_dec(n8("00000000000000000000000000400000"), h("0000000000000000"), h("0579E00B945ED0B2"))
		conform_dec(n8("00000000000000000000000000080000"), h("0000000000000000"), h("F0903DB58BEFF8CF"))
		conform_dec(n8("00000000000000000000000000000040"), h("0000000000000000"), h("F75986F389F08110"))
		conform_dec(n8("00000000000000000000000000000000"), h("8000000000000000"), h("8001000180008000"))
		conform_dec(n8("00000000000000000000000000000000"), h("0002000000000000"), h("FE47FF8D0132FF26"))
		conform_dec(n8("00000000000000000000000000000000"), h("0000000000200000"), h("08810001F2600700"))
		conform_dec(n8("00000000000000000000000000000000"), h("0000000000000400"), h("2001B00138006400"))
		conform_dec(n8("11111111111111111111111111111111"), h("1111111111111111"), h("3A1D3B4DB127C8B7"))
		conform_dec(n8("52525252525252525252525252525252"), h("5252525252525252"), h("B255918917D30DB6"))
		conform_dec(n8("66666666666666666666666666666666"), h("6666666666666666"), h("C9248B00868D8651"))
		conform_dec(n8("ABABABABABABABABABABABABABABABAB"), h("ABABABABABABABAB"), h("5A4C4870F25A207F"))
		conform_dec(n8("000102030405060708090A0B0C0D0E0F"), h("0011223344556677"), h("DB2D4A92AA68273F"))
		conform_dec(n8("2BD6459F82C5B300952C49104881FF48"), h("EA024714AD5C4D84"), h("F129A6601EF62A47"))
	end
	
	it "calculates multiplicative inverses" do
		idea = Crypt::IDEA.new("", Crypt::IDEA::ENCRYPT)
		expect(idea.mulInv(0)).to eql(0)
		(1..0xffff).each { |i|
			expect(i * idea.mulInv(i) % 0x10001).to eql(1)
		}	
	end

end
