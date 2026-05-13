BB = float(input("Masukkan Berat Badan (kg): "))
TB = float(input("Masukkan Tinggi Badan (meter): "))

imt = BB/(TB ** 2)

print(f"Halo, skor IMT Anda adalah {imt}")

# kategori
if imt <= 18.5:
    print("Kategori: Kurus")
elif imt <= 25.0:
    print("Kategori: Normal")
elif imt <= 27.0:
    print("Kategori: Gemuk")
else:
    print("Kategori: Obesitas")