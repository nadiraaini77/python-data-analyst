# def add(a=None, b=None):
#     if a == None or b == None:
#         print("Parameter tidak lengkap")
#         return
#     totalTambah = a + b
#     return totalTambah

# # jumlah = add (10,5)
# # print(jumlah)

# def subtract(a=None, b=None):
#     if a == None or b == None:
#         print("Parameter tifsk lengkap")
#         return
    
#     totalKurang = a-b
#     return totalKurang

# # kurang=subtract(5, 10)
# # # print(kurang)

def imt(BB=None, TB= None):
    if BB == None or TB == None:
        print("Parameter tidak lengkap")
        return
    
    total = BB/(TB ** 2)
    return total

def imt_check(imt):
    if imt <= 18.5:
        print("Kategori: Kurus")
    elif imt <= 25.0:
        print("Kategori: Normal")
    elif imt <= 27.0:
        print("Kategori: Gemuk")
    else:
        print("Kategori: Obesitas")