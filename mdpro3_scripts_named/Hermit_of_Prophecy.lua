--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 魔导老士 艾尔米特  (ID: 90743290)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Spellcaster
-- Level 3
-- ATK 1200 | DEF 700
-- Setcode: 110
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，每次名字带有「魔导书」的魔法卡发动，这张卡的等级上升2星，攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--魔導老士 エアミット
function c90743290.initial_effect(c)
	--atk/lvup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetCondition(c90743290.condition)
	e1:SetOperation(c90743290.operation)
	c:RegisterEffect(e1)
end
function c90743290.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsSetCard(0x106e)
end
function c90743290.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
