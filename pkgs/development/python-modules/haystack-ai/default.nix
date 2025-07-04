{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  boilerpy3,
  events,
  httpx,
  jsonschema,
  lazy-imports,
  more-itertools,
  networkx,
  pandas,
  pillow,
  platformdirs,
  posthog,
  prompthub-py,
  pydantic,
  quantulum3,
  rank-bm25,
  requests,
  requests-cache,
  scikit-learn,
  sseclient-py,
  tenacity,
  tiktoken,
  tqdm,
  transformers,
  openai-whisper,
  boto3,
  botocore,
  # , beir
  selenium,
  coverage,
  dulwich,
  # , jupytercontrib
  mkdocs,
  mypy,
  pre-commit,
  psutil,
  # , pydoc-markdown
  pylint,
  pytest,
  pytest-asyncio,
  pytest-cov,
  # , pytest-custom-exit-code
  python-multipart,
  reno,
  responses,
  toml,
  tox,
  watchdog,
  elastic-transport,
  elasticsearch,
  # , azure-ai-formrecognizer
  beautifulsoup4,
  markdown,
  python-docx,
  python-frontmatter,
  python-magic,
  tika,
  black,
  huggingface-hub,
  sentence-transformers,
  mlflow,
  rapidfuzz,
  scipy,
  seqeval,
  pdf2image,
  pytesseract,
  faiss,
  # , faiss-gpu
  pinecone-client,
  onnxruntime,
  onnxruntime-tools,
  # , onnxruntime-gpu
  opensearch-py,
  pymupdf,
  langdetect,
  nltk,
  canals,
  jinja2,
  openai,
  aiorwlock,
  ray,
  psycopg2,
  sqlalchemy,
  sqlalchemy-utils,
  weaviate-client,
}:

buildPythonPackage rec {
  pname = "haystack-ai";
  version = "2.9.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "deepset-ai";
    repo = "haystack";
    tag = "v${version}";
    hash = "sha256-h/4KskpzO3+e6aLQlBb8yitmfdbdc+J6Hz6TMs8bnr8=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  pythonRemoveDeps = [
    # We call it faiss, not faiss-cpu.
    "faiss-cpu"
  ];

  propagatedBuildInputs = [
    boilerpy3
    events
    httpx
    jsonschema
    lazy-imports
    more-itertools
    networkx
    pandas
    pillow
    platformdirs
    posthog
    prompthub-py
    pydantic
    quantulum3
    rank-bm25
    requests
    requests-cache
    scikit-learn
    sseclient-py
    tenacity
    tiktoken
    tqdm
    transformers
  ];

  env.HOME = "$(mktemp -d)";

  optional-dependencies = {
    # all = [
    #   farm-haystack
    # ];
    # all-gpu = [
    #   farm-haystack
    # ];
    audio = [ openai-whisper ];
    aws = [
      boto3
      botocore
    ];
    # beir = [
    #   beir
    # ];
    colab = [ pillow ];
    crawler = [ selenium ];
    dev = [
      coverage
      dulwich
      # jupytercontrib
      mkdocs
      mypy
      pre-commit
      psutil
      # pydoc-markdown
      pylint
      pytest
      pytest-asyncio
      pytest-cov
      # pytest-custom-exit-code
      python-multipart
      reno
      responses
      toml
      tox
      watchdog
    ];
    elasticsearch7 = [
      elastic-transport
      elasticsearch
    ];
    elasticsearch8 = [
      elastic-transport
      elasticsearch
    ];
    file-conversion = [
      # azure-ai-formrecognizer
      beautifulsoup4
      markdown
      python-docx
      python-frontmatter
      python-magic
      # python-magic-bin
      tika
    ];
    formatting = [ black ];
    inference = [
      huggingface-hub
      sentence-transformers
      transformers
    ];
    metrics = [
      mlflow
      rapidfuzz
      scipy
      seqeval
    ];
    ocr = [
      pdf2image
      pytesseract
    ];
    only-faiss = [ faiss ];
    # only-faiss-gpu = [
    #   faiss-gpu
    # ];
    only-pinecone = [ pinecone-client ];
    onnx = [
      onnxruntime
      onnxruntime-tools
    ];
    # onnx-gpu = [
    #   onnxruntime-gpu
    #   onnxruntime-tools
    # ];
    opensearch = [ opensearch-py ];
    pdf = [ pymupdf ];
    preprocessing = [
      langdetect
      nltk
    ];
    preview = [
      canals
      jinja2
      lazy-imports
      openai
      pandas
      rank-bm25
      requests
      tenacity
      tqdm
    ];
    ray = [
      aiorwlock
      ray
    ];
    sql = [
      psycopg2
      sqlalchemy
      sqlalchemy-utils
    ];
    weaviate = [ weaviate-client ];
  };

  # the setup for test is intensive, hopefully can be done at some point
  doCheck = false;

  pythonImportsCheck = [ "haystack" ];

  meta = with lib; {
    description = "LLM orchestration framework to build customizable, production-ready LLM applications";
    longDescription = ''
      LLM orchestration framework to build customizable, production-ready LLM applications. Connect components (models, vector DBs, file converters) to pipelines or agents that can interact with your data. With advanced retrieval methods, it's best suited for building RAG, question answering, semantic search or conversational agent chatbots
    '';
    changelog = "https://github.com/deepset-ai/haystack/releases/tag/${src.tag}";
    homepage = "https://github.com/deepset-ai/haystack";
    license = licenses.asl20;
    maintainers = with maintainers; [ happysalada ];
    # https://github.com/deepset-ai/haystack/issues/5304
    broken = versionAtLeast pydantic.version "2";
  };
}
