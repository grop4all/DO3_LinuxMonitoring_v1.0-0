import os

# скрип для авто загрузки локальных репозиториев на github



# ldir = os.system("ls")
listdir = os.listdir()


# --include-all-branches --public --push --remote <> --source 

for i in listdir:
    print(f"gh repo create --public --push  --remote  github --source ./{i}")
    os.system(f"gh repo create --public --push  --remote github --source ./{i}")
# print(ldir)