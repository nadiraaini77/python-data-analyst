import aritmatika as f

# print(f.add(10, 6))
# print(f.imt(50, 1.7))

BB = float(input("Masukkan Berat Badan (kg): "))
TB = float(input("Masukkan Tinggi Badan (meter): "))

imt = f.imt(BB, TB)
print("IMT kamu adalah", imt)

f.imt_check(imt)