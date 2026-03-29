# Prediction of Rock Mechanical Parameters in Deep Coal-Bearing Formations

This repository contains the official implementation and dataset for the paper:

**"Residual Decomposition for Lithotype-Aware Characterization of Rock Mechanical Parameters from Well Logs under Lithological Heterogeneity"**.

## 📖 Project Overview

Accurate characterization of rock mechanical parameters (UCS, Young’s modulus, and Poisson’s ratio) is essential for deep mining and wellbore stability. This project provides a **data-driven intelligent framework** that integrates:

- **Coal Lithotype Identification:** Using the HMLZ index to classify bright, semi-bright, semi-dull, and dull coal.

- **Advanced ML Modeling:** CatBoost regression optimized by Bayesian Optimization (BO).

- **Model Interpretability:** SHAP-based analysis to quantify feature contributions.

## 🚀 Key Features

- **Lithotype-Aware Prediction:** Incorporates coal types as categorical constraints to handle strong reservoir heterogeneity.

- **High Accuracy:** Achieves $R^2$ of 0.928 on blind-well validation.

- **Explainable AI:** Reveals the dominant influence of acoustic transit time (AC) and density (DEN) on geomechanical properties.

## 📁 Repository Structure

```
├── data/
│   ├── UCS.csv       # Preprocessed logging data from 5 wells
│   └── Xiaohao1.csv     # Well-Validate-1 data
├── src/
│   ├── Xiaohao1.m       # Preprocessed logging data from 5 wells
│   └── Xiaohao101.m     # Core implementation
└── README.md
```

## 🛠️ Requirements

- Python 3.8+

- `catboost`

- `shap`

- `bayesian-optimization`

- `pandas`, `numpy`, `matplotlib`

## 📊 Performance

The optimized model parameters obtained via Bayesian Optimization are:

- **Iterations:** 150

- **Learning Rate:** 0.38

- **Depth:** 3

| **Metric**    | **Training Set** | **Validation Set** | **Test Set** |
| ------------- | ---------------- | ------------------ | ------------ |
| **$R^2$**     | 0.982            | 0.936              | 0.928        |
| **MAE (MPa)** | 0.312            | 0.594              | 0.641        |

## 📝 Citation

If you find this work or the dataset useful for your research, please cite:



```
@article{Liu2026Prediction,
  title={Residual Decomposition for Lithotype-Aware Characterization of Rock Mechanical Parameters from Well Logs under Lithological Heterogeneity},
  author={Liu, Xugang and Dang, Binghua and Li, Lei and Zhang, Weixian and Tan, Qiang and Zhou, Wenze},
  journal={Applied Sciences},
  year={2026}
}
```

---
