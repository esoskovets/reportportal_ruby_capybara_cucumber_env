# Usage

1. Clone Git repository in local folder and go there

2. Build cucumber image with name "cucumber_image"

```console
docker build -t cucumber_image .
```

3. Run test

```console
docker run --rm -ti -v $(pwd)/app/features:/opt/app/features cucumber_image \
cucumber rp_uuid="***" \
rp_endpoint="http://***/api/v1" \
rp_tags="['in_docker','rp_screenshot_bug']" \
rp_project="***" \
rp_launch="***" -f ReportPortal::Cucumber::Formatter
```
