--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 雾之王  (ID: 6614221)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 7
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡召唤的场合，可以用1只祭品或者不用祭品作召唤。这张卡的攻击力变成祭品召唤时作为祭品的怪兽的原本攻击力合计数值。只要这张卡在场上表侧表示存在，任何形式的祭品都不能进行。
--[[ __CARD_HEADER_END__ ]]

--霧の王
function c6614221.initial_effect(c)
	--summon with 1 tribute
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(6614221,0))
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SUMMON_PROC)
	e0:SetCondition(c6614221.ttcon)
	e0:SetOperation(c6614221.ttop)
	e0:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e0)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6614221,1))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c6614221.ntcon)
	c:RegisterEffect(e1)
	--tribute check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c6614221.valcheck)
	c:RegisterEffect(e2)
	--give atk effect only when summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SUMMON_COST)
	e3:SetOperation(c6614221.facechk)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--cannot release
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_RELEASE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	c:RegisterEffect(e4)
end
function c6614221.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c6614221.ttcon(e,c,minc)
	if c==nil then return true end
	return minc<=1 and Duel.CheckTribute(c,1)
end
function c6614221.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,1,1)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c6614221.valcheck(e,c)
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	while tc do
		local catk=tc:GetTextAttack()
		atk=atk+(catk>=0 and catk or 0)
		tc=g:GetNext()
	end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0xff0000)
		c:RegisterEffect(e1)
	end
end
function c6614221.facechk(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end
