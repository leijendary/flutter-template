#!/bin/sh

amplify push \
    --y \
    --allow-destructive-graphql-schema-updates \
amplify codegen models