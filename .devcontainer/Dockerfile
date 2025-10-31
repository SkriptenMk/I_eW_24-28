# Devcontainer base image for Quarto website with XeLaTeX for PDF output
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       wget \
       curl \
       ca-certificates \
       git \
       gnupg \
       lsb-release \
       fonts-dejavu-core \
       fontconfig \
       poppler-utils \
         # graphics libraries required by skia / pytamaro
         libegl1-mesa \
         libgl1-mesa-glx \
         libgbm1 \
    librsvg2-bin \
       unzip \
       xz-utils \
       procps \
       sudo \
       build-essential \
    # minimal TeX packages to support xelatex-based PDF output
    texlive-xetex \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    # fonts and language support
    fonts-lmodern \
    lmodern \
    texlive-fonts-extra \
    texlive-lang-german \
    && mktexlsr || true \
    && rm -rf /var/lib/apt/lists/*

# Install additional font packages (including Microsoft core fonts) and helpers.
# We add debconf-utils/software-properties-common so we can enable multiverse and
# accept the mscorefonts EULA non-interactively, then install fonts and refresh caches.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends software-properties-common debconf-utils fontconfig; \
    # enable multiverse repo (may already be enabled) so ttf-mscorefonts-installer is available
    add-apt-repository multiverse || true; \
    # accept EULA for Microsoft core fonts
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections; \
    apt-get update; \
    apt-get install -y --no-install-recommends ttf-mscorefonts-installer fonts-liberation fonts-noto-core texlive-fonts-extra lmodern; \
    fc-cache -f -v || true; \
    mktexlsr || true; \
    rm -rf /var/lib/apt/lists/*;

# Install Quarto CLI from GitHub releases (keeps image reasonably small)
# Pin a known working version and download the proper asset for the container's architecture.
ENV QUARTO_VERSION=1.9.9

RUN set -eux; \
        # detect architecture and map to Quarto asset naming
        ARCH="$(dpkg --print-architecture 2>/dev/null || true)"; \
        if [ -z "$ARCH" ]; then ARCH="$(uname -m)"; fi; \
        case "$ARCH" in \
            amd64|x86_64) QARCH="linux-amd64" ;; \
            arm64|aarch64) QARCH="linux-arm64" ;; \
            *) QARCH="linux-amd64" ;; \
        esac; \
        QUARTO_DEB="/tmp/quarto.deb"; \
        DOWNLOAD_URL="https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-${QARCH}.deb"; \
        echo "Downloading Quarto from: ${DOWNLOAD_URL}"; \
        curl -fL --retry 5 --retry-delay 2 -o "${QUARTO_DEB}" "${DOWNLOAD_URL}"; \
        dpkg -i "${QUARTO_DEB}" || true; \
        apt-get update; \
        apt-get -f install -y; \
        # Install python3-pip and required Python packages for notebook execution
        apt-get install -y --no-install-recommends python3-pip; \
        # Upgrade pip and install Jupyter-related packages used by Quarto to execute notebooks
        python3 -m pip install --upgrade pip setuptools wheel; \
    python3 -m pip install jupyter pyyaml nbconvert ipykernel; \
    # refresh TeX filename database so kpsewhich finds newly installed packages
    mktexlsr || true; \
    rm -f "${QUARTO_DEB}"; \
    rm -rf /var/lib/apt/lists/*;

# Create a non-root user 'vscode' to match default VS Code devcontainer conventions
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME || true \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /workspace

# Copy Python requirements and install them so notebooks run inside the container
COPY requirements.txt /tmp/requirements.txt
RUN set -eux; \
    python3 -m pip install --no-cache-dir -r /tmp/requirements.txt; \
    rm -f /tmp/requirements.txt

USER $USERNAME

ENV PATH="/home/$USERNAME/.local/bin:${PATH}"

CMD ["bash"]
