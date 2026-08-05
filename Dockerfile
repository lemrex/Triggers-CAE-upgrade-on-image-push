FROM ubuntu:22.04

# Install runtime + build deps in one layer, clean apt cache in same layer
RUN apt-get update && apt-get install -y --no-install-recommends \
        expect \
        curl \
        jq \
        ca-certificates \
        bash \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://ap-southeast-3-hwcloudcli.obs.ap-southeast-3.myhuaweicloud.com/cli/latest/hcloud_install.sh \
        -o /tmp/hcloud_install.sh \
    && bash /tmp/hcloud_install.sh -y \
    && rm -f /tmp/hcloud_install.sh

ENV PATH="/root/.hcloud/bin:/usr/local/bin:${PATH}"

RUN hcloud version

# Copy entrypoint last — changes most often, keeps cache valid for the layers above
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
