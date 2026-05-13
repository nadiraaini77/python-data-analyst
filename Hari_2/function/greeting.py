# FUNCTION dasar -> pake def (python)
from datetime import datetime
def sapa():
    print("HELLO 67!")

def sapa_nama(nama=None):
    if nama is None:
        print("Silakan masukkan nama")
        return
    print(f"Hello {nama}")

# print("Sebelum memamggil fungsi") panggil dulu,
# sapa()
sapa_nama()
# print(datetime.now())

# def salam(nama):
#     print(f"Assalamualaikum, {nama} ^^")
# salam("")
# print(datetime.now())