# DICTIONARY
import json
data = {
    "nama depan": "alice",
    "nama belakang": "sitompul",
    "alamat": "turi",
    "umur": 23,
    "hobi": ["mancing", "catur", "gaplek"]
}

# print(data)
print(data["alamat"])
data["alamat"] = "Ngawi"
print("\n setelah diubah")
print(data["alamat"])

# BIG DATA
BigData = [
    {
    "nama depan": "alice",
    "nama belakang": "sitompul",
    "alamat": "turi",
    "umur": 23,
    "hobi": ["mancing", "catur", "gaplek"],
    },
    {
    "nama depan": "Bento",
    "nama belakang": "Sihotang",
    "alamat": "Gamping",
    "umur": 24,
    "hobi": ["roblox", "ml", "ff"],
    },
]
BigData.append(
    {
        "nama depan": "edi",
        "nama belakang": "silalahi",
        "alamat": "sanden",
        "umur": 21,
        "hobby": ["tiktok", "masak", "netflix"],
    }
)
print(json.dumps(BigData, indent=4))