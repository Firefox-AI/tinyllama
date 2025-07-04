from transformers import LlamaConfig, LlamaForCausalLM
import torch

# Define minimal model config
config = LlamaConfig(
    vocab_size=32,
    hidden_size=32,
    intermediate_size=64,
    num_hidden_layers=1,
    num_attention_heads=1,
    num_key_value_heads=1,
    max_position_embeddings=32,
    rms_norm_eps=1e-5,
    bos_token_id=1,
    eos_token_id=2,
    pad_token_id=0,
)

# Build and save the model
model = LlamaForCausalLM(config)
model.save_pretrained("tiny-llama")
