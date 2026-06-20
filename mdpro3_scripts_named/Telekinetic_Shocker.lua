--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 念动攻击者  (ID: 84847656)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Psychic
-- Level 4
-- ATK 1700 | DEF 700
--
-- Effect Text:
-- 念动力族怪兽被破坏的场合，可以支付500基本分作为代替把这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--テレキアタッカー
function c84847656.initial_effect(c)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c84847656.destg)
	e1:SetValue(c84847656.value)
	e1:SetOperation(c84847656.desop)
	c:RegisterEffect(e1)
end
function c84847656.dfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsRace(RACE_PSYCHO) and not c:IsReason(REASON_REPLACE)
end
function c84847656.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not eg:IsContains(e:GetHandler())
		and Duel.CheckLPCost(tp,500) and eg:IsExists(c84847656.dfilter,1,nil) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.PayLPCost(tp,500)
		return true
	else return false end
end
function c84847656.value(e,c)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsRace(RACE_PSYCHO) and not c:IsReason(REASON_REPLACE)
end
function c84847656.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
