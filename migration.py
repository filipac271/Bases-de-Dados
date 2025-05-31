import mysql.connector
from mysql.connector import IntegrityError
from decimal import Decimal
import csv
import json

def insereCliente(cursor, clientes):
    for cliente in clientes:
        try:
            cursor.execute("""
                INSERT INTO Cliente (Nome, Rua, Localidade, CodigoPostal, NIF, LocalTrabalho)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (
                cliente['Nome'],
                cliente['Rua'],
                cliente['Localidade'],
                cliente['CodigoPostal'],
                cliente['NIF'],
                cliente['LocalTrabalho']
            ))
        except IntegrityError as e:
            if e.errno == 1062:
                print(f"Entrada duplicada Cliente ignorada: {e}")
            else:
                print(f"Erro de integridade Cliente: {e}")
        except Exception as e:
            print(f"Erro inesperado Cliente: {e}")

def insereClienteContacto(cursor, contactos):
    for contacto in contactos:
        try:
            cursor.execute("""
                INSERT INTO Cliente_Contacto (ClienteId, Telefone, Email)
                VALUES (%s, %s, %s)
            """, (
                contacto['ClienteId'],
                contacto['Telefone'],
                contacto['Email']
            ))
        except IntegrityError as e:
            if e.errno == 1062:
                print(f"Entrada duplicada Cliente_Contacto ignorada: {e}")
            else:
                print(f"Erro de integridade Cliente_Contacto: {e}")
        except Exception as e:
            print(f"Erro inesperado Cliente_Contacto: {e}")

def insereAutomovel(cursor, automoveis):
    for auto in automoveis:
        try:
            cursor.execute("""
                INSERT INTO Automovel (Marca, Kilometragem, Ano, Estado, TipoConsumo, PrecoDia, FilialId)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (
                auto['Marca'],
                auto['Kilometragem'],
                auto['Ano'],
                auto['Estado'],
                auto['TipoConsumo'],
                auto['PrecoDia'],
                auto['FilialId']
            ))
        except IntegrityError as e:
            if e.errno == 1062:
                print(f"Entrada duplicada Automovel ignorada: {e}")
            else:
                print(f"Erro de integridade Automovel: {e}")
        except Exception as e:
            print(f"Erro inesperado Automovel: {e}")

def insereFuncionario(cursor, funcionarios):
    for func in funcionarios:
        try:
            cursor.execute("""
                INSERT INTO Funcionario (Nome, NIF, Salario, Email, Telefone, FilialId)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (
                func['Nome'],
                func['NIF'],
                func['Salario'],
                func['Email'],
                func['Telefone'],
                func['FilialId']
            ))
        except IntegrityError as e:
            if e.errno == 1062:
                print(f"Entrada duplicada Funcionario ignorada: {e}")
            else:
                print(f"Erro de integridade Funcionario: {e}")
        except Exception as e:
            print(f"Erro inesperado Funcionario: {e}")

def insereAluguer(cursor, alugueres):
    for aluguer in alugueres:
        try:
            cursor.execute("""
                INSERT INTO Aluguer (DataInicio, DataFim, Preco, Multa, FuncionarioId, ClienteId, AutomovelId, RecolhidoFilialId, DevolvidoFilialId)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
                aluguer['DataInicio'],
                aluguer['DataFim'],
                aluguer['Preco'],
                aluguer['Multa'],
                aluguer['FuncionarioId'],
                aluguer['ClienteId'],
                aluguer['AutomovelId'],
                aluguer['RecolhidoFilialId'],
                aluguer['DevolvidoFilialId']
            ))
        except IntegrityError as e:
            if e.errno == 1062:
                print(f"Entrada duplicada Aluguer ignorada: {e}")
            else:
                print(f"Erro de integridade Aluguer: {e}")
        except Exception as e:
            print(f"Erro inesperado Aluguer: {e}")

def insereFuncao(cursor, funcoes):
    for funcao in funcoes:
        try:
            cursor.execute("""
                INSERT INTO Funcao (Designacao, SalarioBase)
                VALUES (%s, %s)
            """, (
                funcao['Designacao'],
                funcao['SalarioBase']
            ))
        except IntegrityError as e:
            if e.errno == 1062:
                print(f"Entrada duplicada Funcao ignorada: {e}")
            else:
                print(f"Erro de integridade Funcao: {e}")
        except Exception as e:
            print(f"Erro inesperado Funcao: {e}")

def insereExerce(cursor, exerces):
    for exerce in exerces:
        try:
            cursor.execute("""
                INSERT INTO Exerce (FuncionarioId, FuncaoId)
                VALUES (%s, %s)
            """, (
                exerce['FuncionarioId'],
                exerce['FuncaoId']
            ))
        except IntegrityError as e:
            if e.errno == 1062:
                print(f"Entrada duplicada Exerce ignorada: {e}")
            else:
                print(f"Erro de integridade Exerce: {e}")
        except Exception as e:
            print(f"Erro inesperado Exerce: {e}")
            
            
            

def migraJson(cursor):
    with open('Dados/PortugalBD.json', 'r', encoding='utf-8') as f:
        dados = json.load(f)
    
    insereCliente(cursor, dados.get('Cliente', []))
    insereClienteContacto(cursor, dados.get('Cliente_Contacto', []))
    insereAutomovel(cursor, dados.get('Automovel', []))
    insereFuncionario(cursor, dados.get('Funcionario', []))
    insereAluguer(cursor, dados.get('Aluguer', []))
    insereFuncao(cursor, dados.get('Funcao', []))
    insereExerce(cursor, dados.get('Exerce', []))



def migraCsv(cursor):
    with open('Dados/BelgaBD.csv', newline='', encoding='utf-8') as ficheiro:
        leitor = csv.reader(ficheiro, delimiter=';')  
        for linha in leitor:
            print(linha)
            try:
                tipo = linha[0]

                if tipo == 'Cliente':
                        nome, rua, localidade, codigoPostal, nif, localTrabalho = linha[1:]
                        print(codigoPostal)
                        cursor.execute(
                            "INSERT INTO Cliente (Nome, Rua, Localidade, CodigoPostal, NIF, LocalTrabalho) VALUES (%s, %s, %s, %s, %s, %s);",
                            (nome, rua, localidade, codigoPostal, nif, localTrabalho)
                        )

                elif tipo == 'Cliente_Contacto':

                        clienteId = int(linha[1])
                        telefone = linha[2]
                        email = linha[3] if linha[3] else None
                        cursor.execute(
                            "INSERT INTO Cliente_Contacto (ClienteId, Telefone, Email) VALUES (%s, %s, %s);",
                            (clienteId, telefone, email)
                        )

                elif tipo == 'Automovel':

                        marca = linha[1]
                        kilometragem = float(linha[2])
                        ano = int(linha[3])
                        estado = linha[4]
                        tipoConsumo = linha[5]
                        precoDia = Decimal(linha[6])
                        filialId = int(linha[7])
                        cursor.execute(
                            "INSERT INTO Automovel (Marca, Kilometragem, Ano, Estado, TipoConsumo, PrecoDia, FilialId) VALUES (%s, %s, %s, %s, %s, %s, %s);",
                            (marca, kilometragem, ano, estado, tipoConsumo, precoDia, filialId)
                        )

                elif tipo == 'Funcionario':

                        nome = linha[1]
                        nif = linha[2]
                        salario = Decimal(linha[3])
                        email = linha[4] if linha[4] else None
                        telefone = linha[5]
                        filialId = int(linha[6])
                        cursor.execute(
                            "INSERT INTO Funcionario (Nome, NIF, Salario, Email, Telefone, FilialId) VALUES (%s, %s, %s, %s, %s, %s);",
                            (nome, nif, salario, email, telefone, filialId)
                        )

                elif tipo == 'Aluguer':

                        dataInicio = linha[1]  # assumindo formato correto
                        dataFim = linha[2]
                        preco = Decimal(linha[3])
                        multa = Decimal(linha[4]) if linha[4] else None
                        clienteId = int(linha[5])
                        funcionarioId = int(linha[6])
                        automovelId = int(linha[7])
                        recolhidoFilialId = int(linha[8])
                        devolvidoFilialId = int(linha[9])
                        cursor.execute(
                            "INSERT INTO Aluguer (DataInicio, DataFim, Preco, Multa, ClienteId, FuncionarioId, AutomovelId, RecolhidoFilialId, DevolvidoFilialId) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);",
                            (dataInicio, dataFim, preco, multa, clienteId, funcionarioId, automovelId, recolhidoFilialId, devolvidoFilialId)
                        )

                elif tipo == 'Funcao':

                        designacao = linha[1]
                        salarioBase = Decimal(linha[2])
                        cursor.execute(
                            "INSERT INTO Funcao (Designacao, SalarioBase) VALUES (%s, %s);",
                            (designacao, salarioBase)
                        )

                elif tipo == 'Exerce':

                        funcionarioId = int(linha[1])
                        funcaoId = int(linha[2])
                        cursor.execute(
                            "INSERT INTO Exerce (FuncionarioId, FuncaoId) VALUES (%s, %s);",
                            (funcionarioId, funcaoId)
                        )
            except IntegrityError as e:
                # Erro de entrada duplicada (código 1062 no MySQL)
                if e.errno == 1062:
                    print(f"Entrada duplicada ignorada: {e}")
                else:
                    print(f"Erro de integridade: {e}")
            except Exception as e:
                # Para outros erros
                print(f"Erro inesperado: {e}")

            

def main():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="BelaRentaCar"
    )

    cursor = conn.cursor()

    migraCsv(cursor)
    migraJson(cursor)
    conn.commit()


    cursor.execute("SELECT * FROM Automovel")
    resultados = cursor.fetchall()

    for row in resultados:
        print(row)


    cursor.close()
    conn.close()
    


if __name__ == "__main__":
    main()



