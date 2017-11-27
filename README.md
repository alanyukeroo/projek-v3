# Tugas 3 IF3110 Pengembangan Aplikasi Berbasis Web

Melakukan upgrade Website ojek online sederhana pada Tugas 2 dengan mengaplikasikan ***cloud service* (Firebase Cloud Messaging) dan *framework* MEAN stack**.

**Luangkan waktu untuk membaca spek ini sampai selesai. Kerjakan hal yang perlu saja.**

## Tujuan Pembuatan Tugas

Diharapkan dengan tugas ini Anda dapat mengerti:
* MEAN stack (Mongo, Express, Angular, dan Node)
* *Cloud service* Firebase Cloud Messaging (FCM) dan kegunaannya.
* Web security terkait access token dan HTTP Headers.

## Anggota Tim
1. Faiz Ghifari Haznitrama - 13515010
2. Afif Bambang Prasetia - 13515058
3. Letivany Aldina - 13514067
4. Mahesa Gandakusuma - 13513091

![](img/arsitektur_umum.png)

### Arsitektur Umum
Tugas 3 ini terdiri dari komponen Tugas 2 dan tambahan yang harus dibuat:
* `Pemanfaatan FCM`: Pengiriman pesan dari pelanggan ke driver atau sebaliknya dengan menggunakan layanan Firebase Cloud Messaging (FCM).
* `Implementasi MEAN stack`: Membuat REST service untuk keperluan layanan chat memanfaatkan FCM menggunakan Node, Express dan Mongo, serta membuat halaman chat yang menggunakan Angular

### Pembagian Tugas

Chat App Front-end :
1. Halaman Chat Driver untuk passenger : 13515010  
2. Halaman order untu driver : 13515010  


Chat REST Service:  
1. Modul chat : 1315058  
2. Modul driver dan firebaseToken : 13515010
3. REST Service chat, driver, firebaseToken : 13515010 

Fitur security (IP, User-agent) :


## About

Faiz | Afif | Letivany | Mahesa
