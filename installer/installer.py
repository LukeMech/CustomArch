import subprocess
import tkinter as tk

def install():
    disk = disk_var.get()
    language = lang_var.get()
    username = user_entry.get()
    password = passwd_entry.get()
    kernel = kernel_var.get()

    # Format disk
    subprocess.run(["mkfs.ext4", disk])

    # Mount disk
    subprocess.run(["mount", disk, "/mnt"])

    # Install Arch Linux
    subprocess.run(["pacstrap", "/mnt", "base", kernel])

    # Configure Arch Linux
    subprocess.run(["arch-chroot", "/mnt"])
    subprocess.run(["ln", "-sf", "/usr/share/zoneinfo/Europe/Warsaw", "/etc/localtime"])
    subprocess.run(["hwclock", "--systohc"])
    subprocess.run(["echo", "LANG=" + language, ">", "/etc/locale.conf"])
    subprocess.run(["locale-gen"])
    # subprocess.run(["echo", "KEYMAP=" + keyboard, ">", "/etc/vconsole.conf"])
    # subprocess.run(["echo", "arch" + ">", "/etc/hostname"])
    subprocess.run(["passwd"])
    subprocess.run(["useradd", "-m", "-g", "users", "-G", "wheel,storage,power", "-s", "/bin/bash", username])
    subprocess.run(["usermod", '--password', "$(echo" + password + "| openssl passwd -1 -stdin)", username])

root = tk.Tk()
root.title("Arch Linux Installer")

disks = subprocess.run(["lsblk", "-d", "-n", "-o", "NAME"], stdout=subprocess.PIPE).stdout.decode().strip().split("\n")
disk_var = tk.StringVar()
disk_var.set(disks[0])

disk_label = tk.Label(root, text="Choose disks:")
disk_label.pack()

disk_menu = tk.OptionMenu(root, disk_var, *disks)
disk_menu.pack()

lang_var = tk.StringVar()
lang_var.set("en_US.UTF-8")

lang_label = tk.Label(root, text="Choose language:")
lang_label.pack()

lang_menu = tk.OptionMenu(root, lang_var, "pl_PL.UTF-8", "en_US.UTF-8")
lang_menu.pack()

user_label = tk.Label(root, text="Username:")
user_label.pack()
user_entry = tk.Entry(root)
user_entry.pack()
user_passwd = tk.Label(root, text="Password:")
user_passwd.pack()
passwd_entry = tk.Entry(root)
passwd_entry.pack()

kernel_var = tk.StringVar()
kernel_var.set("linux")

kernel_label = tk.Label(root, text="Choose kernel:")
kernel_label.pack()

kernel_menu = tk.OptionMenu(root, kernel_var, "linux", "linux-lts", "linux-zen")
kernel_menu.pack()

install_button = tk.Button(root, text="Install", command=install)
install_button.pack()

root.mainloop()