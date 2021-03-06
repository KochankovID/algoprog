React = require('react')

import Material from '../components/Material'
import Sceleton from '../components/Sceleton'
import ConnectedComponent from '../lib/ConnectedComponent'

class MaterialPage extends React.Component
    constructor: (props) ->
        super(props)

    render:  () ->
        sceletonProps = {@props..., location: {title: @props.data?.title, path: @props.data?.path, _id: @props.data?._id}}
        `<Sceleton {...sceletonProps}><Material {...this.props} material={this.props.data}/></Sceleton>`

options =
    urls: (props) ->
        data: "material/#{props.match.params.id}"

export default MaterialPageConnected = ConnectedComponent(MaterialPage, options)
