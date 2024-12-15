program ManajemenBahanBangunan;

uses crt;

type
    // Record untuk Bahan Bangunan
    BahanBangunan = record
        Kode: string[10];
        NamaBahan: string[50];
        Harga: real;
        Stok: integer;
    end;

const
    MAX_BAHAN = 100;
    BIAYA_PER_KM = 2000;

var
    Bahan: array[1..MAX_BAHAN] of BahanBangunan;
    JumlahBahan: integer;
    pilihan: char;

// Prosedur untuk input data bahan bangunan
procedure InputBahan(var B: BahanBangunan);
begin
    writeln('Masukkan Kode Bahan:');
    readln(B.Kode);
    writeln('Masukkan Nama Bahan:');
    readln(B.NamaBahan);
    writeln('Masukkan Harga Bahan:');
    readln(B.Harga);
    writeln('Masukkan Stok Bahan:');
    readln(B.Stok);
end;

// Prosedur untuk menampilkan semua data bahan bangunan
procedure TampilkanBahan;
var
    i: integer;
begin
    if JumlahBahan = 0 then
    begin
        writeln('Tidak ada data bahan bangunan.');
    end
    else
    begin
        writeln('Daftar Bahan Bangunan:');
        for i := 1 to JumlahBahan do
        begin
            writeln('Kode: ', Bahan[i].Kode);
            writeln('Nama: ', Bahan[i].NamaBahan);
            writeln('Harga: Rp', Bahan[i].Harga:0:2);
            writeln('Stok: ', Bahan[i].Stok);
            writeln('---------------------------------------');
        end;
    end;
end;

// Prosedur untuk menambahkan bahan bangunan
procedure TambahBahan;
begin
    if JumlahBahan < MAX_BAHAN then
    begin
        Inc(JumlahBahan);
        InputBahan(Bahan[JumlahBahan]);
    end
    else
        writeln('Stok bahan sudah penuh!');
end;

// Prosedur untuk melakukan transaksi penjualan
procedure TransaksiPenjualan;
var
    KodeCari: string[10];
    JumlahBeli, Jarak: integer;
    Metode: char;
    TotalHarga, BiayaAntar: real;
    ditemukan: boolean;
    i: integer;
begin
    if JumlahBahan = 0 then
    begin
        writeln('Tidak ada data bahan bangunan.');
        Exit;
    end;

    writeln('Masukkan Kode Bahan yang ingin dibeli:');
    readln(KodeCari);

    // Cari bahan berdasarkan kode
    ditemukan := False;
    for i := 1 to JumlahBahan do
    begin
        if Bahan[i].Kode = KodeCari then
        begin
            ditemukan := True;
            writeln('Nama Bahan: ', Bahan[i].NamaBahan);
            writeln('Harga: Rp', Bahan[i].Harga:0:2);
            writeln('Stok Saat Ini: ', Bahan[i].Stok);
            writeln('Masukkan Jumlah yang Ingin Dibeli:');
            readln(JumlahBeli);

            // Validasi stok
            if JumlahBeli <= Bahan[i].Stok then
            begin
                TotalHarga := Bahan[i].Harga * JumlahBeli;
                Bahan[i].Stok := Bahan[i].Stok - JumlahBeli;

                // Pilih metode pengambilan
                writeln('Pilih Metode Pengambilan:');
                writeln('1. Diantar');
                writeln('2. Ambil Sendiri');
                write('Masukkan pilihan (1/2): ');
                readln(Metode);

                if Metode = '1' then
                begin
                    writeln('Masukkan Jarak Pengantaran (dalam kilometer):');
                    readln(Jarak);
                    BiayaAntar := Jarak * BIAYA_PER_KM;
                    TotalHarga := TotalHarga + BiayaAntar;
                    writeln('Biaya Pengantaran: Rp', BiayaAntar:0:2);
                end
                else if Metode = '2' then
                begin
                    writeln('Pengambilan dilakukan sendiri.');
                end
                else
                begin
                    writeln('Pilihan tidak valid.');
                    Exit;
                end;

                writeln('Transaksi berhasil!');
                writeln('Total Harga: Rp', TotalHarga:0:2);
            end
            else
                writeln('Stok tidak mencukupi!');
            break;
        end;
    end;

    if not ditemukan then
        writeln('Kode bahan tidak ditemukan!');
end;

begin
    clrscr;
    JumlahBahan := 0;

    // Menu utama
    repeat
        writeln('=============================');
        writeln('1. Tambah Bahan Bangunan');
        writeln('2. Tampilkan Bahan Bangunan');
        writeln('3. Transaksi Penjualan');
        writeln('4. Keluar');
        writeln('=============================');
        write('Pilih menu (1-4): ');
        
        readln(pilihan); // Membaca pilihan menu dari pengguna
        
        case pilihan of
            '1': TambahBahan;
            '2': TampilkanBahan;
            '3': TransaksiPenjualan;
            '4': writeln('Terima kasih, program selesai!');
        else
            writeln('Pilihan tidak valid, coba lagi.');
        end;
        writeln;
    until pilihan = '4'; // Program selesai jika pilihan 4 dipilih
    
    readln;
end.
