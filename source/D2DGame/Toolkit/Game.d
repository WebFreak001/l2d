module D2DGame.Toolkit.Game;

import D2D;

abstract class Game
{
private:
	int	   _width  = 800, _height = 480;
	Bitmap _icon   = null;
	Window _window = null;
	string _title  = "Game";
	int	   _fps	   = 60;

protected:
	@property ref int windowWidth()
	{
		return _width;
	}

	@property ref int windowHeight()
	{
		return _height;
	}

	@property ref Bitmap windowIcon()
	{
		return _icon;
	}

	@property ref string windowTitle()
	{
		return _title;
	}

	@property ref string maxFPS()
	{
		return _title;
	}

	@property Window window()
	{
		return _window;
	}

	abstract void init()
	{
	}

	abstract void load()
	{
	}

	abstract void update(float delta)
	{
	}

	abstract void draw()
	{
	}

	void onEvent(Event event)
	{
	}

public:
	void run()
	{
		init();

		_window = new Window(_width, _height, _title);

		if (_icon is null)
		{
			_icon = new Bitmap(
				[
					0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
					0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0x00ffffff,
					0xffffffff, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff9c9c9c, 0xff000000, 0xff000000, 0xff000000, 0xff383838, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xff303030, 0xff303030, 0xff303030, 0xff1c1c1c, 0xff000000, 0xff9c9c9c, 0xffcccccc, 0xff000000, 0xff292929, 0xff303030, 0xff292929, 0xff000000, 0xff6d6d6d, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff707070, 0xff131313, 0xff000000, 0xffcccccc, 0xff303030, 0xffb7b7b7, 0xffcccccc, 0xffb7b7b7, 0xff131313, 0xff000000, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff555555, 0xff000000, 0xff9c9c9c, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff1e1e1e, 0xff000000, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffa7a7a7, 0xff000000, 0xff6d6d6d, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffb0b0b0, 0xff000000, 0xff555555, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffb0b0b0, 0xff000000, 0xff727272, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff333333, 0xff0d0d0d, 0xffa7a7a7, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff8b8b8b, 0xff000000, 0xff909090, 0xffcccccc, 0xffcccccc, 0xff545454, 0xff000000, 0xff5b5b5b, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff444444, 0xff060606, 0xffb7b7b7, 0xffcccccc, 0xff545454, 0xff000000, 0xff454545, 0xffcccccc, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff545454, 0xff000000, 0xff343434, 0xffcccccc, 0xff545454, 0xff000000, 0xff303030, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff303030, 0xffa7a7a7, 0xffb0b0b0, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xffffffff,
					0xffffffff, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xff454545, 0xffcccccc, 0xffcccccc, 0xffb7b7b7, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xffffffff,
					0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0x00ffffff,
					0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
					0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
				], 16, 16, 32, 0x00FF0000, 0x0000FF00, 0x000000FF, 0xFF000000);
		}

		_window.setIcon(_icon);

		FPSLimiter limiter;
		if (_fps > 0)
			limiter = new FPSLimiter(_fps);

		load();

		Event event;
		while (_window.open)
		{
			while (_window.pollEvent(event))
			{
				if (event.type == Event.Type.Quit)
					_window.close();
				else
					onEvent(event);
			}

			update(0);

			draw();

			_window.display();

			if (limiter !is null)
				limiter.wait();
		}
	}
}
