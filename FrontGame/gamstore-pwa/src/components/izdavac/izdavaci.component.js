import React, { Component } from "react";
import { Container, Table } from "react-bootstrap";


export default class Izdavaci extends Component{


    render(){
        return (
            <Container>
                <a href="/izdavaci/dodaj" className="btn btn-success gumb">
                    Dodaj novog izdavaca
                </a>

                <Table strict bordered hover responsive>
                    <thead>
                        <tr>
                            <th>Naziv</th>
                            <th>Drzava</th>
                            <th>Web Stranica</th>
                            <th>Akcija</th>
                        </tr>
                    </thead>
                    <tbody>
                        {/* Ovdje će doći podaci s backend-a */}
                    </tbody>
                </Table>





            </Container>
            

        );
    }
}