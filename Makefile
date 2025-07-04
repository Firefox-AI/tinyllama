# Makefile for generating and converting a minimal GGUF model

VENV_DIR := .venv
PYTHON := $(VENV_DIR)/bin/python
LLAMA_DIR := llama.cpp
MODEL_DIR := tiny-llama
GGUF_FILE := tiny-llama.gguf

.PHONY: all clean

all: $(GGUF_FILE)

$(VENV_DIR)/bin/activate:
	python3 -m venv $(VENV_DIR)
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt

$(LLAMA_DIR):
	git clone https://github.com/ggerganov/llama.cpp.git
	$(PYTHON) -m pip install -r $(LLAMA_DIR)/requirements.txt

$(MODEL_DIR): $(VENV_DIR)/bin/activate
	$(PYTHON) generate.py

$(MODEL_DIR)/tokenizer.model:
	cp tokenizer.model $(MODEL_DIR)/tokenizer.model

$(GGUF_FILE): $(MODEL_DIR) $(MODEL_DIR)/tokenizer.model $(LLAMA_DIR)
	cd $(LLAMA_DIR) && $(PYTHON) convert_hf_to_gguf.py ../$(MODEL_DIR) --outfile ../$(GGUF_FILE)

clean:
	rm -rf $(VENV_DIR) $(LLAMA_DIR) $(MODEL_DIR) $(GGUF_FILE)
