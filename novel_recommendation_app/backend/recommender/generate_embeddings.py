import numpy as np
import time
from database import SessionLocal
from models import Novel
from recommender.embedder import get_embedder
from recommender.preprocess import split_novel_text

WEIGHTS = {
    "tropes": 0.5,
    "genre": 0.3,
    "synopsis": 0.2
}

def generate(model_name: str):

    print(f"\n🚀 Generating embeddings using: {model_name}")

    db = SessionLocal()
    novels = db.query(Novel).all()

    embedder = get_embedder(model_name)
    final_embeddings = []

    start_time = time.time()

    for idx, novel in enumerate(novels):
        parts = split_novel_text(novel)

        vec = (
            WEIGHTS["tropes"] * embedder.embed([parts["tropes"]])[0]
            + WEIGHTS["genre"] * embedder.embed([parts["genre"]])[0]
            + WEIGHTS["synopsis"] * embedder.embed([parts["synopsis"]])[0]
        )

        final_embeddings.append(vec)

        if idx % 10 == 0:
            print(f"Processed {idx+1}/{len(novels)}")

    end_time = time.time()

    final_embeddings = np.array(final_embeddings)

    output_path = f"embeddings/novel_embeddings_{model_name}.npy"
    np.save(output_path, final_embeddings)

    print(f"✅ Done.")
    print(f"📦 Saved: {output_path}")
    print(f"📐 Shape: {final_embeddings.shape}")
    print(f"⏱ Time Taken: {end_time - start_time:.2f} seconds")


if __name__ == "__main__":
    # for model in ["bert", "e5", "bge"]:
    generate("e5")
