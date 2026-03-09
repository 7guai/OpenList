默认图像是BASE。您可以通过修改BASE_IMAGE_TAG来添加其他支持。支持以下参数：BASE（默认）、aria2、ffmpeg、aio
参数 BASE_IMAGE_TAG=base

从 alpine:edge 作为建设者
标签 stage=go-builder
工作目录 /app/
跑apk add --no-cache bash curl jq gcc git go musl-dev
复制go.mod go.sum ./
跑go mod下载
复制./ ./
跑bash build.sh release docker

# ↓↓↓ 新加：隐藏底部驱动的 CSS 注入 ↓↓↓
跑回声'
.driver-selector,
.driver-picker,
驱动程序链接，
底部驱动器{
显示：无！重要；
}
' >> /app/public/dist/assets/index-*.css
# ↑↑↑ 新加代码结束 ↑↑↑

从openlistteam/openlist-base-image:${BASE_IMAGE_TAG}
标签 MAINTAINER="OpenList"
参数 INSTALL_FFMPEG=false
参数 INSTALL_ARIA2=false
参数 USER=openlist
参数 UID=1001
参数 GID=1001

工作目录 /opt/openlist/

跑addgroup -g ${GID} ${USER} && \
adduser -D -u ${UID} -G ${USER} ${USER} && \
mkdir -p /opt/openlist/data

复制--from=builder --chmod=755 --chown=${UID}:${GID} /app/bin/openlist ./
复制--chmod=755 --chown=${UID}:${GID} entrypoint.sh /entrypoint.sh

用户${用户}
跑/entrypoint.sh版本

环境UMASK=022 RUN_ARIA2=${INSTALL_ARIA2}
体积 /opt/openlist/data/
暴露 5244 5245
命令提示符 [ "/entrypoint.sh" ]
