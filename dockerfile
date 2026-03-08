# 1. استخدام نسخة خفيفة ومستقرة من بايثون
FROM python:3.10-slim

# 2. تعيين مجلد العمل داخل الحاوية
WORKDIR /app

# 3. تثبيت أدوات النظام الضرورية (مهم لبعض المكتبات مثل python-nmap و selenium)
RUN apt-get update && apt-get install -y \
    nmap \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 4. نسخ ملف التكوين أولاً للاستفادة من الـ Cache
COPY pyproject.toml .

# 5. تثبيت المكتبات (نستخدم pip لتثبيت المشروع الحالي)
# نقوم بتحديث pip وتثبيت المتطلبات
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir .

# 6. نسخ بقية ملفات المشروع (مثل main.py)
COPY . .

# 7. الأمر الافتراضي لتشغيل التطبيق
# "start-app" هو الاسم الذي حددناه في [project.scripts] داخل pyproject.toml
CMD ["start-app"]
