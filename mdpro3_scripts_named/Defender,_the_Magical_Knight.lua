--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 魔导骑士 防御者  (ID: 2525268)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1600 | DEF 2000
-- Setcode: 110
--
-- Effect Text:
-- ①：这张卡召唤的场合发动。给这张卡放置1个魔力指示物（最多1个）。
-- ②：1回合1次，场上的魔法师族怪兽被破坏的场合，可以作为代替把那个数量的自己场上的魔力指示物取除。
--[[ __CARD_HEADER_END__ ]]

--魔導騎士 ディフェンダー
function c2525268.initial_effect(c)
	c:EnableCounterPermit(0x1)
	c:SetCounterLimit(0x1,1)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2525268,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c2525268.addct)
	e1:SetOperation(c2525268.addc)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c2525268.destg)
	e2:SetValue(c2525268.value)
	e2:SetOperation(c2525268.desop)
	c:RegisterEffect(e2)
end
function c2525268.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x1)
end
function c2525268.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c2525268.dfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c2525268.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local count=eg:FilterCount(c2525268.dfilter,nil)
		e:SetLabel(count)
		return count>0 and Duel.IsCanRemoveCounter(tp,1,0,0x1,count,REASON_COST)
	end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c2525268.value(e,c)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsRace(RACE_SPELLCASTER)
end
function c2525268.desop(e,tp,eg,ep,ev,re,r,rp)
	local count=e:GetLabel()
	Duel.RemoveCounter(tp,1,0,0x1,count,REASON_COST)
end
