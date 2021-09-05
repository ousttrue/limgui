local ffi = require "ffi"
ffi.cdef [[
typedef int tbool;
typedef struct SMikkTSpaceContext SMikkTSpaceContext;

typedef struct {
    // Returns the number of faces (triangles/quads) on the mesh to be processed.
    int (*m_getNumFaces)(const SMikkTSpaceContext * pContext);

    // Returns the number of vertices on face number iFace
    // iFace is a number in the range {0, 1, ..., getNumFaces()-1}
    int (*m_getNumVerticesOfFace)(const SMikkTSpaceContext * pContext, const int iFace);

    // returns the position/normal/texcoord of the referenced face of vertex number iVert.
    // iVert is in the range {0,1,2} for triangles and {0,1,2,3} for quads.
    void (*m_getPosition)(const SMikkTSpaceContext * pContext, float fvPosOut[], const int iFace, const int iVert);
    void (*m_getNormal)(const SMikkTSpaceContext * pContext, float fvNormOut[], const int iFace, const int iVert);
    void (*m_getTexCoord)(const SMikkTSpaceContext * pContext, float fvTexcOut[], const int iFace, const int iVert);

    // either (or both) of the two setTSpace callbacks can be set.
    // The call-back m_setTSpaceBasic() is sufficient for basic normal mapping.

    // This function is used to return the tangent and fSign to the application.
    // fvTangent is a unit length vector.
    // For normal maps it is sufficient to use the following simplified version of the bitangent which is generated at pixel/vertex level.
    // bitangent = fSign * cross(vN, tangent);
    // Note that the results are returned unindexed. It is possible to generate a new index list
    // But averaging/overwriting tangent spaces by using an already existing index list WILL produce INCRORRECT results.
    // DO NOT! use an already existing index list.
    void (*m_setTSpaceBasic)(const SMikkTSpaceContext * pContext, const float fvTangent[], const float fSign, const int iFace, const int iVert);

    // This function is used to return tangent space results to the application.
    // fvTangent and fvBiTangent are unit length vectors and fMagS and fMagT are their
    // true magnitudes which can be used for relief mapping effects.
    // fvBiTangent is the "real" bitangent and thus may not be perpendicular to fvTangent.
    // However, both are perpendicular to the vertex normal.
    // For normal maps it is sufficient to use the following simplified version of the bitangent which is generated at pixel/vertex level.
    // fSign = bIsOrientationPreserving ? 1.0f : (-1.0f);
    // bitangent = fSign * cross(vN, tangent);
    // Note that the results are returned unindexed. It is possible to generate a new index list
    // But averaging/overwriting tangent spaces by using an already existing index list WILL produce INCRORRECT results.
    // DO NOT! use an already existing index list.
    void (*m_setTSpace)(const SMikkTSpaceContext * pContext, const float fvTangent[], const float fvBiTangent[], const float fMagS, const float fMagT,
                        const tbool bIsOrientationPreserving, const int iFace, const int iVert);
} SMikkTSpaceInterface;

struct SMikkTSpaceContext
{
    SMikkTSpaceInterface * m_pInterface;	// initialized with callback functions
    void * m_pUserData;						// pointer to client side mesh data etc. (passed as the first parameter with every interface call)
};

// these are both thread safe!
tbool genTangSpaceDefault(const SMikkTSpaceContext * pContext);	// Default (recommended) fAngularThreshold is 180 degrees (which means threshold disabled)
tbool genTangSpace(const SMikkTSpaceContext * pContext, const float fAngularThreshold);    
]]

local M = {}

---comment
---@param buffer LoaderBuffer
M.make_tangent = function(buffer)
    if not M.mikktspace then
        M.mikktspace = ffi.load "mikktspace"
    end

    local context = ffi.new "SMikkTSpaceContext[1]"
    local interface = ffi.new "SMikkTSpaceInterface[1]"
    interface[0].m_getNumFaces = function(pContext)
        return buffer.POSITION.count / 3
    end
    interface[0].m_getNumVerticesOfFace = function(pContext)
        return 3
    end
    interface[0].m_getPosition = function(pContext, fvPosOut, iFace, iVert)
        local index = iFace * 3 + iVert
        local vertex_index = buffer.indices.slice[index]
        local vertex = buffer.POSITION.slice[vertex_index]
        fvPosOut[0] = vertex.x
        fvPosOut[1] = vertex.y
        fvPosOut[2] = vertex.z
    end
    interface[0].m_getNormal = function(pContext, fvNormOut, iFace, iVert)
        local index = iFace * 3 + iVert
        local vertex_index = buffer.indices.slice[index]
        local vertex = buffer.NORMAL.slice[vertex_index]
        fvNormOut[0] = vertex.x
        fvNormOut[1] = vertex.y
        fvNormOut[2] = vertex.z
    end
    interface[0].m_getTexCoord = function(pContext, fvTexcOut, iFace, iVert)
        local index = iFace * 3 + iVert
        local vertex_index = buffer.indices.slice[index]
        local vertex = buffer.TEXCOORD_0.slice[vertex_index]
        fvTexcOut[0] = vertex.x
        fvTexcOut[1] = vertex.y
    end

    local tangent = ffi.new("vec4[?]", buffer.POSITION.count)
    interface[0].m_setTSpaceBasic = function(pContext, fvTangent, fSign, iFace, iVert)
        local index = iFace * 3 + iVert
        local vertex_index = buffer.indices.slice[index]
        tangent[vertex_index].x = fvTangent[0]
        tangent[vertex_index].y = fvTangent[1]
        tangent[vertex_index].z = fvTangent[2]
        tangent[vertex_index].w = fSign
    end

    context[0].m_pInterface = interface
    M.mikktspace.genTangSpaceDefault(context)

    return { slice = tangent, count = buffer.POSITION.count }
end

return M
