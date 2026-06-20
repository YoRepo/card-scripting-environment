--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 幻奏的音女 阿莉娅  (ID: 40502912)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 155
--
-- Effect Text:
-- ①：只要特殊召唤的这张卡在怪兽区域存在，自己场上的「幻奏」怪兽不会成为效果的对象，不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--幻奏の音女アリア
function c40502912.initial_effect(c)
	--cannot be target/battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x9b))
	e1:SetCondition(c40502912.tgcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	c:RegisterEffect(e2)
end
function c40502912.tgcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
