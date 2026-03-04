from recommender.models.bert_model import BERTEmbedder
from recommender.models.e5_model import E5Embedder
from recommender.models.bge_model import BGEEmbedder

def get_embedder(model_name: str):
    model_name = model_name.lower()

    if model_name == "bert":
        return BERTEmbedder()
    if model_name == "e5":
        return E5Embedder()
    if model_name in ["bge", "bge-m3"]:
        return BGEEmbedder()

    raise ValueError("Choose model from: bert | e5 | bge")
