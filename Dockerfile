FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    expect \
    curl \
    jq \
    ca-certificates \
    bash \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://hwcloudcli.obs.cn-north-1.myhuaweicloud.com/cli/latest/hcloud_install.sh \
    -o /tmp/hcloud_install.sh \
 && bash /tmp/hcloud_install.sh -y \
 && rm -f /tmp/hcloud_install.sh

ENV PATH="/root/.hcloud/bin:/usr/local/bin:${PATH}"

RUN hcloud version

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
