# ============================================================
#  Masa Technology — Custom Odoo 18 Community Image
#  Base: official odoo:18.0 from Docker Hub
#  Adds: OCA addons + Masa custom addons
# ============================================================
FROM odoo:18.0

USER root

# ── System dependencies ──────────────────────────────────────
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# ── Python dependencies for custom addons ───────────────────
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# ── OCA Addons (pinned to 18.0 branch) ──────────────────────
RUN git clone --depth=1 -b 18.0 \
    https://github.com/OCA/partner-contact.git \
    /mnt/oca-addons/partner-contact

RUN git clone --depth=1 -b 18.0 \
    https://github.com/OCA/web.git \
    /mnt/oca-addons/web

RUN git clone --depth=1 -b 18.0 \
    https://github.com/OCA/account-financial-tools.git \
    /mnt/oca-addons/account-financial-tools

# ── Custom Addons (copied from repo) ────────────────────────
# All environments share the same image — addons_path in
# odoo.conf (managed by Helm) controls which are active per env
COPY custom-addons/ /mnt/custom-addons/

# ── Fix permissions ──────────────────────────────────────────
RUN chown -R odoo:odoo /mnt/oca-addons /mnt/custom-addons

# ── Switch back to odoo user ─────────────────────────────────
USER odoo

# Expose Odoo ports
EXPOSE 8069 8072
