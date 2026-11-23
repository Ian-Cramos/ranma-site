
FROM haskell:9.10.3-bookworm

WORKDIR /app

COPY . .

RUN cabal update

RUN cabal build exe:ranma-site

RUN cp "$(cabal list-bin exe:ranma-site)" /usr/local/bin/ranma-site

ENV PORT=10000

EXPOSE 10000

CMD ["ranma-site"]
