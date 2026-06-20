--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 幻变骚灵·延迟菲芬尼拉  (ID: 12977245)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Spellcaster
-- Level 2
-- ATK 0 | DEF 1000
-- Setcode: 259
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，对方不能选择「幻变骚灵·延迟菲芬尼拉」以外的自己场上的「幻变骚灵」怪兽作为攻击对象，也不能作为效果的对象。
--[[ __CARD_HEADER_END__ ]]

--オルターガイスト・フィフィネラグ
function c12977245.initial_effect(c)
	--can't be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c12977245.atlimit)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c12977245.tglimit)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function c12977245.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x103) and not c:IsCode(12977245)
end
function c12977245.tglimit(e,c)
	return c:IsSetCard(0x103) and not c:IsCode(12977245)
end
