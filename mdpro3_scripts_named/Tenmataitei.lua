--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 天魔大帝  (ID: 90122655)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 5
-- ATK 2400 | DEF 1000
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，对方不能对应通常召唤的怪兽的效果的发动把魔法·陷阱·怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--天魔大帝
function c90122655.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c90122655.chainop)
	c:RegisterEffect(e1)
end
function c90122655.chainop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if re:IsActiveType(TYPE_MONSTER) and loc==LOCATION_MZONE and rc:IsSummonType(SUMMON_TYPE_NORMAL) then
		Duel.SetChainLimit(c90122655.chainlm)
	end
end
function c90122655.chainlm(e,rp,tp)
	return tp==rp
end
