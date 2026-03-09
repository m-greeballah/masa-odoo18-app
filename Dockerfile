# ============================================================
#  Masa Technology — Custom Odoo 18 Community Image
#  Base: official odoo:18.0 from Docker Hub
#  Adds: OCA addons + Masa custom addons
# ============================================================
FROM odoo:18.0

USER root

# ── System dependencies ──────────────────────────────────────
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# ── Python dependencies for custom addons ───────────────────
COPY requirements.txt /tmp/requirements.txt
# Only run pip install if requirements.txt has real (non-comment) content
RUN grep -qvE '^\s*(#|$)' /tmp/requirements.txt \
    && pip3 install --no-cache-dir -r /tmp/requirements.txt \
    || echo "No Python dependencies to install — skipping."

# ── OCA Addons + Custom Addons in a single RUN ──────────────
# DL3059: consolidated all git clones into one RUN block
RUN git clone --depth=1 -b 18.0 \
        https://github.com/OCA/partner-contact.git \
        /mnt/oca-addons/partner-contact \
    && git clone --depth=1 -b 18.0 \
        https://github.com/OCA/web.git \
        /mnt/oca-addons/web \
    && git clone --depth=1 -b 18.0 \
        https://github.com/OCA/account-financial-tools.git \
        /mnt/oca-addons/account-financial-tools \
    && chown -R odoo:odoo /mnt/oca-addons

# ── Custom Addons ────────────────────────────────────────────
COPY custom-addons/ /mnt/custom-addons/
RUN chown -R odoo:odoo /mnt/custom-addons

# ── Switch back to odoo user ─────────────────────────────────
USER odoo

EXPOSE 8069 8072
