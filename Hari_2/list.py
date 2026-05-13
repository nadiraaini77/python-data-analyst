# List - Kumpulan Data Terurut
# 1. List
nama = ["Alice", "Bob", "Charlie"]
nilai = [85, 90, 95]
print(nama)
print(nilai)

# print dengan index
# print("\n")
# print("Print dengan index")
# print(f"Nama {nama[1]} mendapatkan nilai {nilai[1]}") #urutan sesuai dengan nilai & nama yg ke-1 [1]

# for z in range(3): # range 3 karena ada 3 orang
#     print(z) # z itu indeks
#     print((f"Nama {nama[z]} mendapatkan nilai {nilai[z]}"))

# kalo ratusan gimana? pake panjang data, yaitu len
# for z in range(len(nama)):
#     print(z)
#     print((f"Nama {nama[z]} mendapatkan nilai {nilai[z]}"))

# print("Print dengan index")
# print(f"panjang data dari nama = {len(nama)}")

# 2. Akses elemen
print("Print dengan index")
#..... tbc

# 3. Slicing
index = [0, 1, 2, 3, 4, 5, 6]
nama = ["Alice", "Bob", "Charlie", "Edi", "Farah", "Gita", "Hasti"]
nilai = [85, 90, 95, 100, 80, 75, 65]
nama_slice_3_tengah = nama[2:5]
nilai_slice_3_tengah = nilai[2:5]
print(nama_slice_3_tengah)
#print(nilai_slice_3_tengah)

#INSERT
nama_slice_3_tengah.insert(1, "Dina")
#nama_slice_3_tengah.insert(1, 85)
print("\n")
print(nama_slice_3_tengah)
#print(nilai_slice_3_tengah)

#APPEND
nama_slice_3_tengah.append("Zara")
nilai_slice_3_tengah.append(100)
print("\n APPEND")
print(nama_slice_3_tengah)
#print(nilai_slice_3_tengah)

#SORT
nama_slice_3_tengah.sort()
print("\n SORT")
print(nama_slice_3_tengah)
