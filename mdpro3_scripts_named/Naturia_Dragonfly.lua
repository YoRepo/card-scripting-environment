--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 自然蜻蜓  (ID: 70083723)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 4
-- ATK 1200 | DEF 400
-- Setcode: 42
--
-- Effect Text:
-- 这张卡不会被和攻击力2000以上的怪兽的战斗破坏。这张卡的攻击力上升自己墓地存在的名字带有「自然」的怪兽数量×200的数值。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ドラゴンフライ
function c70083723.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c70083723.indes)
	c:RegisterEffect(e1)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c70083723.atkval)
	c:RegisterEffect(e1)
end
function c70083723.indes(e,c)
	if c:IsDefensePos() and Duel.GetAttacker()==c then
		return c:IsDefenseAbove(2000)
	else
		return c:IsAttackAbove(2000)
	end
end
function c70083723.filter(c)
	return c:IsSetCard(0x2a) and c:IsType(TYPE_MONSTER)
end
function c70083723.atkval(e,c)
	return Duel.GetMatchingGroupCount(c70083723.filter,c:GetControler(),LOCATION_GRAVE,0,nil)*200
end
