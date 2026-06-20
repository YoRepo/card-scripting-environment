--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 黑翼的魔术师  (ID: 49826746)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 3
-- ATK 1300 | DEF 1200
-- Setcode: 152
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，这张卡的控制者可以在「爆裂模式」盖放的回合发动。
--[[ __CARD_HEADER_END__ ]]

--黒翼の魔術師
function c49826746.initial_effect(c)
	aux.AddCodeList(c,80280737)
	--Trap activate in set turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49826746,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,80280737))
	c:RegisterEffect(e1)
end
