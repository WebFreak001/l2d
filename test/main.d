import D2D;

import std.algorithm;

Texture shurikenTex;

class Shuriken : RectangleShape
{
	vec2 offs;
	float rotaSpeed = 0;

	public this(int x, int y, int xa, int ya, float rotation)
	{
		super();
		texture = shurikenTex;
		offs = vec2(xa * 0.5f, ya * 0.5f);
		if (offs.length < 1)
			offs = offs.normalized();
		if (offs.length > 10)
			offs = offs.normalized() * 10;
		origin = vec2(64, 64);
		this.rotation = rotation;
		rotaSpeed = 0.1f * max(0.1f, offs.length * 0.05f);
		position = vec2(x, y);
		setSize(vec2(128, 128));
	}

	void update(float delta)
	{
		move(offs * delta * 100);
		rotate(rotaSpeed * delta * 100);
	}

	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		matrixStack.push();
		matrixStack.top = matrixStack.top * transform;
		if (texture !is null)
			texture.bind(0);
		shader.bind();
		shader.set("invTransWorld", matrixStack.top.inverse().transposed());
		target.draw(_mesh, shader);
		matrixStack.pop();
	}

	bool isIn(int width, int height)
	{
		return position.x > -80 && position.y > -80 && position.x < width + 80 && position.y < height + 80;
	}
}

class Game1 : Game
{
private:
	Shuriken[]    shuriken;
	Shuriken mouse;
	int lastX, lastY;
	int currentX, currentY;
	bool clicked = false;
	ShaderProgram shader;
	Texture normal;
	Sound whosh;
	TTFFont font;
	IText text;

public:
	override void init()
	{
		windowWidth = 1280;
		windowHeight = 720;
		windowTitle = "Shuriken Simulator EXTREME SUPER ULTRA DELUXE EDITION OMEGA 2.WHOA";
		maxFPS = 0;
		flags |= WindowFlags.Resizable;
	}

	override void load()
	{
		Music music = new Music("song.mp3");
		music.play(0);

		whosh = new Sound("whoosh.wav");

		shurikenTex = new Texture("res/tex/shuriken-color.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.Linear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);
		mouse = new Shuriken(0, 0, 0, 0, 0);

		font = new TTFFont();
		font.load("res/font/Roboto.ttf", 32);

		text = font.render("Shuriken Simulator EXTERME SUPER ULTRA DELUXE EDITION OMEGA 2.WHOA");
		text.size = 0.5f;

		shader = new ShaderProgram();
		shader.attach(Shader.create(ShaderType.Vertex, import ("default.vert")));
		shader.attach(Shader.create(ShaderType.Fragment, import ("normal.frag")));
		shader.link();
		shader.registerUniform("projection");
		shader.registerUniform("transform");
		shader.registerUniform("tex");
		shader.registerUniform("tex2");
		shader.registerUniform("invTransWorld");

		shader.set("tex", 0);
		shader.set("tex2", 1);

		normal = new Texture("res/tex/shuriken-normal.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.Linear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);
	}

	override void update(float delta)
	{
		int width = window.width;
		int height = window.height;
		for (int i = shuriken.length - 1; i >= 0; i--)
		{
			shuriken[i].update(delta);
			if (!shuriken[i].isIn(width, height))
			{
				shuriken[i].dispose();
				shuriken = shuriken.remove!(o => o == shuriken[i])();
			}
		}
	}

	override void onEvent(Event event)
	{
		switch (event.type)
		{
		case Event.Type.MouseButtonPressed:
			clicked = true;
			break;
		case Event.Type.MouseMoved:
			lastX = currentX;
			lastY = currentY;
			currentX = event.x;
			currentY = event.y;
			break;
		case Event.Type.MouseButtonReleased:
			clicked = false;
			shuriken ~= new Shuriken(event.x, event.y, event.x - lastX, event.y - lastY, mouse.rotation);
			whosh.play();
			break;
		case Event.Type.Resized:
			window.resize(event.width, event.height);
			std.stdio.writefln("New Size: %sx%s", event.width, event.height);
			break;
		default:
			break;
		}
	}

	override void draw()
	{
		window.clear(Color3.SkyBlue);

		for (int i = shuriken.length - 1; i >= 0; i--)
		{
			normal.bind(1);
			window.draw(shuriken[i], shader);
		}

		if (clicked)
		{
			mouse.position = vec2(currentX, currentY);
			normal.bind(1);
			window.draw(mouse, shader);
		}

		window.draw(text);
	}
}

void main()
{
	new Game1().run();
}
