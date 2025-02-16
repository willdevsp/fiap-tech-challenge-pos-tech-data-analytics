import streamlit as st

st.set_page_config(page_title="Início", layout="wide", initial_sidebar_state="collapsed",
    menu_items={
        'Get Help': None,  # Remove o link "Get Help"
        'Report a bug': None,  # Remove o link "Report a bug"
        'About': None  # Remove o link "About"
    }
        )

hide_default_menu = """
 <style>
    /* Oculta o menu lateral padrão do Streamlit */
    #MainMenu {visibility: hidden;}
    footer {visibility: hidden;}
 </style>
"""
st.markdown(hide_default_menu, unsafe_allow_html=True)

st.title(':fuelpump: Desenvolvimento de dashboard interativo e modelo de machine learning sobre o preço do petróleo Brent')
    
st.markdown(''' O Brent é uma classificação de petróleo cru que é utilizada como referência para a precificação do insumo. Seu valor flutua conforme diversos fatores, desde crises a decisões da OPEP. 
               No cenário hipotético proposto do **Tech Challenge** da **Fase 4** da **Pós Tech FIAP**, fomos contratados por uma consultoria, e um cliente da mesma solicitou uma análise exploratória dos dados do site da IPEA, além da criação de um modelo de machine learning capaz de realizar o forecasting do preço do barril do petróleo.
               Embasados nessa solicitação e nesses dados, e com ajuda de ferramentas como **Power BI**, **Python** e **Streamlit**, cumprimos com a solicitação nesta aplicação.  ''')
    # Código HTML + CSS para centralizar a imagem
st.markdown(
        """
        <div style="display: flex; justify-content: center;">
            <img src="https://www.moneytimes.com.br/uploads/2021/09/petroleo.jpg" width="320">
        </div>
        """,
        unsafe_allow_html=True
    )


st.info("Selecione uma das opções no menu lateral para visualizar previsões ou análises.")

hide_default_sidebar = """
<style>
    /* Oculta o menu lateral padrão do Streamlit */
    div[data-testid="stSidebarNav"] {display: none;}

    /* Ajusta o espaçamento da barra lateral */
    section[data-testid="stSidebar"] {
        top: 0px !important;
        height: 100vh !important;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        padding-top: 0px !important;
    }

    /* Remove margens extras e sobe o conteúdo do sidebar */
    div[data-testid="stSidebarContent"] {
        margin-top: 0px !important;
        padding-top: 0px !important;
    }
</style>
"""
st.markdown(hide_default_sidebar, unsafe_allow_html=True)

def gerar_menu_lateral():
 st.sidebar.title("📊 Menu")
 st.sidebar.write("Navegue pelas páginas abaixo:")
 st.sidebar.page_link("App.py", label="🏠 Página Inicial")
 st.sidebar.page_link("pages/Analise_exploratoria.py", label="📊 Análise exploratória")
 st.sidebar.page_link("pages/Machine_Learning.py", label="🤖 Machine Learning")
 st.sidebar.page_link("pages/Team.py", label=":technologist: Equipe")

gerar_menu_lateral()



st.markdown("---")
