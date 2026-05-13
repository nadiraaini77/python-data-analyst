# Match case & ternary operator
nilai = input("Masukkan Nilai (1-7): ")

match nilai:
    case "1" | "2" | "3":
        print("hari kerja awal")
    case "4" | "5":
        print("hari kerja akhir")
    case "6" | "7":
        print("weekend")


# match case dengan operator
nilai2 = int(input("Masukkan Nilai (1-7): "))
match nilai2:
    case nilai2 if nilai2 >= 1 and nilai2 <= 3:
        print("hari kerja awal")
    case nilai2 if nilai2 >= 4 and nilai2 <= 5:
        print("hari kerja akhir")
    case nilai2 if nilai2 >= 6 and nilai2 <= 7:
        print("weekend")