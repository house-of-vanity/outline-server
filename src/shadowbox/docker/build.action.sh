#!/bin/bash -eu
#
# Copyright 2018 The Outline Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Environment inputs:
# - SB_VERSION
# - SB_IMAGE
# - ARCH
# - NODE_IMAGE
# - ROOT_DIR

export DOCKER_CONTENT_TRUST="${DOCKER_CONTENT_TRUST:-1}"
export DOCKER_BUILDKIT=1
readonly SB_VERSION=${SB_VERSION:-latest}
readonly SB_IMAGE=${SB_IMAGE:-ultradesu/shadowbox}

docker buildx create --name mybuilder --use

docker buildx build --platform linux/amd64,linux/arm64 \
    --build-arg VERSION="${SB_VERSION}" \
    --build-arg NODE_IMAGE="node:18.16-alpine3.16" \
    -f src/shadowbox/docker/Dockerfile \
    -t "${SB_IMAGE}" \
    --push \
    .
