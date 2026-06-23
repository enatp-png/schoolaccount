วิธีใช้งานบน GitHub Pages + Supabase

1) เข้า Supabase > SQL Editor แล้วรันไฟล์ supabase.sql ทั้งหมด
2) ไปที่ Supabase > Project Settings > API แล้วคัดลอก Project URL และ anon public key
3) เปิดไฟล์ config.js แล้วใส่ค่า SUPABASE_URL และ SUPABASE_ANON_KEY
4) อัปโหลดไฟล์ index.html และ config.js ขึ้น GitHub repository
5) เปิด GitHub Pages จาก Settings > Pages > Deploy from branch

ไฟล์หลัก:
- index.html = หน้าเว็บระบบบัญชี
- config.js = ค่าการเชื่อมต่อ Supabase
- config.example.js = ตัวอย่างไฟล์ตั้งค่า
- supabase.sql = SQL สร้างฐานข้อมูลและ Policy

หมายเหตุความปลอดภัย:
ตอนนี้เปิดให้ anon key อ่าน/เพิ่ม/แก้ไข/ลบได้ เพื่อให้ใช้งานกับ GitHub Pages ทันทีโดยไม่ต้องล็อกอิน หากใช้ข้อมูลจริงที่สำคัญ ควรเพิ่มระบบ Login ด้วย Supabase Auth แล้วเปลี่ยน RLS policy
