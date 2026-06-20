--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 守墓的巫女  (ID: 3381441)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- ATK 1000 | DEF 1500
-- Setcode: 46
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，场地变成「王家长眠之谷」。场地魔法卡表侧表示存在的场合，这个效果不适用。此外，只要这张卡在场上表侧表示存在，场上的名字带有「守墓」的怪兽的攻击力·守备力上升200。
--[[ __CARD_HEADER_END__ ]]

--墓守の巫女
function c3381441.initial_effect(c)
	--field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CHANGE_ENVIRONMENT)
	e1:SetValue(47355498)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2e))
	e2:SetValue(200)
	c:RegisterEffect(e2)
	--Def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x2e))
	e3:SetValue(200)
	c:RegisterEffect(e3)
end
