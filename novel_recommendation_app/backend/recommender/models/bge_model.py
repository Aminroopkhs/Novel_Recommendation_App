from transformers import AutoTokenizer, AutoModel
import torch

class BGEEmbedder:
    def __init__(self):
        self.tokenizer = AutoTokenizer.from_pretrained("BAAI/bge-m3")
        self.model = AutoModel.from_pretrained("BAAI/bge-m3")

    def embed(self, texts):
        tokens = self.tokenizer(
            texts, padding=True, truncation=True, return_tensors="pt"
        )
        with torch.no_grad():
            output = self.model(**tokens)
            embeddings = output.last_hidden_state.mean(dim=1)
        return embeddings.numpy()
