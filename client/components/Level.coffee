React = require('react')
FontAwesome = require('react-fontawesome')

import { Link } from 'react-router-dom'

Label = (props) ->
    <div dangerouslySetInnerHTML={{__html: props.material.content}}>
    </div>

Page = (props) ->
    <div>
        <Link to={"/material/" + props.material._id}>{props.material.title}</Link>
    </div>

LinkMaterial = (props) ->
    <div>
        <FontAwesome name={props.head}/> <a href={props.material.href}>{props.material.title}</a>
    </div>

Contest = (props) ->
    <div>
        <Link to={"/contest/" + props.material._id}>{props.material.title}</Link>
    </div>

Material = (props) ->
    switch props.material.type
        when 'label' then `<Label {...props}/>`
        when 'page' then `<Page {...props}/>`
        when 'pdf' then `<LinkMaterial head="file-pdf-o" {...props}/>`
        when 'image' then `<LinkMaterial head="picture-o" {...props}/>`
        when 'contest' then `<Contest {...props}/>`
        else <div>{props.material.type}</div>

export default Level = (props) ->
    <div>
    {
    res = []
    a = (el) -> res.push(el)
    for m in props.level.materials
        a(<div style={{marginLeft: m.indent}} key={m._id}>
            <Material material={m}/>
        </div>)
    res}
    </div>
