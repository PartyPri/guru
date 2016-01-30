require "spec_helper"

describe EnumHelper do
  subject { Class.new { include EnumHelper } }

  context '.enum' do
    let(:field) { :fake_field }
    let(:opts) { [:opt_1, :opt_2] }

    it 'sets the field instance var' do
      subject.enum(field, *opts)
      expect(subject.instance_variable_get(:@field)).to eq field
    end

    it 'sets the enum_map instance var' do
      subject.enum(field, *opts)
      expect(subject.instance_variable_get(:@enum_map)).to be_a_kind_of(Hash)
    end

    it 'calls the add_active_record_methods method' do
      expect(subject).to receive(:_add_active_record_methods)
      subject.enum(field, *opts)
    end

    context 'adding class methods' do
      before { subject.enum(field, *opts) }

      it 'adds a class method for the field' do
        expect(subject.respond_to?(:fake_field_states)).to eq true
      end

      it 'the class method returns the map' do
        expect(subject.fake_field_states).to eq subject._enum_map
      end
    end

    context 'adding instance methods' do
      let(:instance) { subject.new }
      subject do
        Class.new { include EnumHelper; attr_accessor :fake_field }
      end

      before { subject.enum(field, *opts) }

      it 'adds boolean methods for each option' do
        opts.each do |opt|
          expect(instance.respond_to?("#{opt}?")).to eq true
        end
      end

      it 'the bool method returns true when the option is set' do
        instance.fake_field = 0
        expect(instance.opt_1?).to eq true
      end

      it 'adds setter methods for each option' do
        opts.each do |opt|
          expect(instance.respond_to?("#{opt}=")).to eq true
        end
      end

      it 'the setter method sets the field' do
        instance.opt_1 = true
        expect(instance.fake_field).to eq 0
      end

      context 'when the setter method receives anything but true' do
        it 'raises an error' do
          expect {instance.opt_1 = "hello"}.to raise_error(TypeError)
        end
      end
    end
  end
end