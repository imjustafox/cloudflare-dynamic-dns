FROM python:3.13-alpine

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    HOME=/tmp

WORKDIR /app

# The updater needs requests and dotenv only. requirements.txt also lists the
# systemd binding, which is skipped here: there is no journal in a container and
# building it needs systemd headers.
RUN apk add --no-cache sqlite-libs \
 && pip install --no-cache-dir \
      "requests==2.32.5" \
      "python-dotenv==1.1.1" \
 && pip uninstall -y pip \
 && rm -rf /root/.cache

COPY core.py entrypoint.sh ./
RUN chmod 0755 entrypoint.sh

USER 65532:65532

ENTRYPOINT ["/app/entrypoint.sh"]
