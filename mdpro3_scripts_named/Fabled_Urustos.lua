--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔轰神 乌尔史特斯  (ID: 73040500)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 4
-- ATK 1500 | DEF 200
-- Setcode: 53
--
-- Effect Text:
-- 自己手卡是2张以下的场合，自己场上表侧表示存在的名字带有「魔轰神」的怪兽的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--魔轟神ウルストス
function c73040500.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c73040500.con)
	e1:SetTarget(c73040500.tg)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
function c73040500.con(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)<=2
end
function c73040500.tg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x35)
end
