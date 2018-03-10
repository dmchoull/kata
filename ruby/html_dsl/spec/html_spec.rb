require 'spec_helper.rb'

describe HTML do
  it 'can make a simple document' do
    src = HTML.document {
      h1 { str 'Test' }
      p { str 'Hello, World!' }
    }

    expect(src).to eq('<html><h1>Test</h1><p>Hello, World!</p></html>')
  end

  it 'can create lists' do
    src = HTML.document {
      ul {
        li { str 'item 1' }
        li { str 'item 2' }
      }
    }

    expect(src).to eq('<html><ul><li>item 1</li><li>item 2</li></ul></html>')
  end

  it 'does not allow invalid nesting of tags' do
    expect do
      HTML.document {
        ul {
          p { str 'invalid' }
        }
      }
    end.to raise_error 'p tag is not allowed to be nested within a ul'
  end

  it 'allows html attributes to be set on tags' do
    src = HTML.document {
      h1(classes: 'main-heading') {
        str 'Test'
      }

      ul(classes: 'dropdown') {
        li {
          a(href: 'www.example.com/1', classes: 'btn btn-lg') { str 'link 1'}
        }

        li {
          a(href: 'www.example.com/2', classes: 'btn btn-lg') { str 'link 2' }
        }
      }
    }

    expect(src).to eq('
      <html>
        <h1 class="main-heading">Test</h1>
        <ul class="dropdown">
          <li>
            <a href="www.example.com/1" class="btn btn-lg">link 1</a>
          </li>
          <li>
            <a href="www.example.com/2" class="btn btn-lg">link 2</a>
          </li>
        </ul>
      </html>
    '.strip.gsub(/\s+(?=<)/, ''))
  end
end
