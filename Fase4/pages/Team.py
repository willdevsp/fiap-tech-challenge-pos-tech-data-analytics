import streamlit as st

from App import gerar_menu_lateral  # Importar a função do menu lateral

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

# Chamar a função do menu lateral
gerar_menu_lateral()



st.markdown(
        """
        <div style="display: flex; justify-content: center;">
            <img src="https://postech.fiap.com.br/imgs/courses/digital-product-management/fiap-alura-pm3.png" width="320">
        </div>
        """,
        unsafe_allow_html=True
    )
st.title(":technologist: Membros da equipe")
st.subheader('Power BI')
st.markdown('''
            - Ana Carolina da Silva Carriel **RM 352918**
            - Lucas Sutil da Silva **RM 357431**
            ''')
st.subheader('Machine learning')
st.markdown('''
            - William de Araujo Almeida **RM 357057**
            - Gabriel Madeira Menacho **RM 357318**
            ''')
st.subheader('Streamlit')
st.markdown('''
            - Salomão José Freitas Bonilha **RM 357058**
            ''')




