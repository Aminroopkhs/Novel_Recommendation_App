from transformers import AutoTokenizer, AutoModel
import torch

class E5Embedder:
    def __init__(self):
        self.tokenizer = AutoTokenizer.from_pretrained("intfloat/e5-small-v2")
        self.model = AutoModel.from_pretrained("intfloat/e5-small-v2")

    def embed(self, texts):
        texts = [f"passage: {t}" for t in texts]
        tokens = self.tokenizer(
            texts, padding=True, truncation=True, return_tensors="pt"
        )
        with torch.no_grad():
            output = self.model(**tokens)
            embeddings = output.last_hidden_state.mean(dim=1)
        return embeddings.numpy()
