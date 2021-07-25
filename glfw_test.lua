-- port from
--
-- * https://www.glfw.org/docs/latest/quick.html
--
local glfw = require("glfw")
local glfwc = glfw.glfwc

local vertex_shader_text = [[#version 110
uniform mat4 MVP;
attribute vec3 vCol;
attribute vec2 vPos;
varying vec3 color;
void main()
{
    gl_Position = MVP * vec4(vPos, 0.0, 1.0);
    color = vCol;
};
]]

local fragment_shader_text = [[#version 110
varying vec3 color;
void main()
{
    gl_FragColor = vec4(color, 1.0);
};
]]

local function error_callback(error, description)
    print(string.format("Error: %s\n", description))
end

local function key_callback(window, key, scancode, action, mods)
    if key == glfwc.GLFW_KEY_ESCAPE and action == glfwc.GLFW_PRESS then
        glfw.setWindowShouldClose(window, glfwc.GLFW_TRUE)
    end
end

--     GLuint vertex_buffer, vertex_shader, fragment_shader, program;
--     GLint mvp_location, vpos_location, vcol_location;

glfw.setErrorCallback(error_callback)

if glfw.init() == 0 then
    assert(false)
end

glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MAJOR, 2)
glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MINOR, 0)

local window = glfw.Window:__new(640, 480, "Simple example", nil, nil)
if not window then
    glfw.terminate()
    assert(false)
end

window:setKeyCallback(key_callback)

window:makeContextCurrent();
gladLoadGL(glfwGetProcAddress);
--     glfwSwapInterval(1);

--     // NOTE: OpenGL error checks have been omitted for brevity

--     glGenBuffers(1, &vertex_buffer);
--     glBindBuffer(GL_ARRAY_BUFFER, vertex_buffer);
--     glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

--     vertex_shader = glCreateShader(GL_VERTEX_SHADER);
--     glShaderSource(vertex_shader, 1, &vertex_shader_text, NULL);
--     glCompileShader(vertex_shader);

--     fragment_shader = glCreateShader(GL_FRAGMENT_SHADER);
--     glShaderSource(fragment_shader, 1, &fragment_shader_text, NULL);
--     glCompileShader(fragment_shader);

--     program = glCreateProgram();
--     glAttachShader(program, vertex_shader);
--     glAttachShader(program, fragment_shader);
--     glLinkProgram(program);

--     mvp_location = glGetUniformLocation(program, "MVP");
--     vpos_location = glGetAttribLocation(program, "vPos");
--     vcol_location = glGetAttribLocation(program, "vCol");

--     glEnableVertexAttribArray(vpos_location);
--     glVertexAttribPointer(vpos_location, 2, GL_FLOAT, GL_FALSE,
--                           sizeof(vertices[0]), (void*) 0);
--     glEnableVertexAttribArray(vcol_location);
--     glVertexAttribPointer(vcol_location, 3, GL_FLOAT, GL_FALSE,
--                           sizeof(vertices[0]), (void*) (sizeof(float) * 2));

--     while (!glfwWindowShouldClose(window))
--     {
--         float ratio;
--         int width, height;
--         mat4x4 m, p, mvp;

--         glfwGetFramebufferSize(window, &width, &height);
--         ratio = width / (float) height;

--         glViewport(0, 0, width, height);
--         glClear(GL_COLOR_BUFFER_BIT);

--         mat4x4_identity(m);
--         mat4x4_rotate_Z(m, m, (float) glfwGetTime());
--         mat4x4_ortho(p, -ratio, ratio, -1.f, 1.f, 1.f, -1.f);
--         mat4x4_mul(mvp, p, m);

--         glUseProgram(program);
--         glUniformMatrix4fv(mvp_location, 1, GL_FALSE, (const GLfloat*) mvp);
--         glDrawArrays(GL_TRIANGLES, 0, 3);

--         glfwSwapBuffers(window);
--         glfwPollEvents();
--     }

--     glfwDestroyWindow(window);

--     glfwTerminate();
--     exit(EXIT_SUCCESS);
-- }
