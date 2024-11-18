# 使用 Python 3.9 作为基础镜像
FROM python: 3.11.9

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 复制 pip 配置文件`
COPY pip.conf /etc/pip.conf

# 设置工作目录
WORKDIR /home/applications/fastApiProject

# 复制 requirements.txt 文件
COPY requirements.txt .

# 安装自定义库
RUN pip install -v --no-cache-dir --extra-index-url https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt || exit 1

# 复制应用代码
COPY . .

# 设置容器启动时的默认命令
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--loop", "asyncio", "--proxy-headers"]

